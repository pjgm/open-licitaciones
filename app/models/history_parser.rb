# frozen_string_literal: true

require_relative "../../config/application"

Thread.report_on_exception = false

module OpenLicitaciones
  class HistoryParser
    BASE_URL = "https://contrataciondelestado.es/"
    def self.parse(page)
      url = BASE_URL + "siteindex.xml"
      file = "sitemap_L#{page}.xml"

      url = BASE_URL + file
      doc = Nokogiri::HTML(open(url))
      urls = doc.search("//loc").map(&:text).compact

      urls.each_slice(100).each do |urls_group|
        threads = []
        urls_group.each do |url|
          threads << Thread.new do
            contracts = []
            agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
            agent.get(url) do |page|
              contracts.push ItemParser.new(page).parse
            end
            Importer.import(contracts)
          end
        end
        threads.each { |thr| thr.join }
      end
    end
  end
end
