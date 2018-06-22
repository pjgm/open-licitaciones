# frozen_string_literal: true

require_relative "../../config/application"

Thread.report_on_exception = false

module OpenLicitaciones
  class ParseSitemap
    BASE_URL = "https://contrataciondelestado.es/"
    def self.parse(page_number)
      file = "sitemap_L#{page_number}.xml"

      doc = Nokogiri::HTML(open(BASE_URL + file))
      urls = doc.search("//loc").map(&:text).compact

      urls.each_slice(10).each do |urls_group|
        threads = []
        urls_group.each do |url|
          threads << Thread.new do
            contracts = []
            agent = Mechanize.new { |a| a.user_agent_alias = "Mac Safari" }
            agent.get(url) do |page|
              begin
                item = ItemParser.new(page).parse
                contracts.push(item)
              rescue StandardError
              end
            end
            Importer.import(contracts)
          end
        end
        threads.each(&:join)
        sleep 5
      end
    end
  end
end
