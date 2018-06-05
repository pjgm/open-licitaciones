# frozen_string_literal: true

require_relative "../../config/application"

Thread.report_on_exception = false

module OpenLicitaciones
  class HistoryParser
    BASE_URL = "https://contrataciondelestado.es/"
    def self.parse(page)
      url = BASE_URL + "siteindex.xml"
      @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
      file = "sitemap_L#{page}.xml"

      url = BASE_URL + file
      doc = Nokogiri::HTML(open(url))
      urls = doc.search("//loc").map(&:text).compact

      urls.each_slice(100).each do |urls_group|
        contracts = []
        threads = []
        urls_group.each do |url|
          threads << Thread.new do
            @agent.get(url) do |page|
              contracts.push ItemParser.new(page).parse
            end
          end
        end
        threads.each { |thr| thr.join }
        Importer.import(contracts)
      end
    end
  end
end
