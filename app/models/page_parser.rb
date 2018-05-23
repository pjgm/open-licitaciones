# frozen_string_literal: true

require_relative "../../config/boot"

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
          contract = parse_item @agent.click(page.link_with(:href => href))
          @contracts.push contract
        end
      end

      @contracts
    end

    def parse_item(item_page)
      ItemParser.new(item_page).parse
    end
  end
end
