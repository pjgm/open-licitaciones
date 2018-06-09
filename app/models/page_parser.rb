# frozen_string_literal: true

require_relative "../../config/application"

module OpenLicitaciones
  class PageParser
    def initialize(url, agent)
      @agent = agent
      @url = url
      @contracts = []
    end

    def parse
      @agent.get(@url) do |page|
        page.search(".tdidExpedienteWidth a").map{|h| h['href'] }.each do |href|
          if contract = parse_item(@agent.click(page.link_with(:href => href)))
            @contracts.push contract
          end
        end
      end

      @contracts
    end

    def parse_item(item_page)
      ItemParser.new(item_page).parse
    rescue
    end
  end
end
