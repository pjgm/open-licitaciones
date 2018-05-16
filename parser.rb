# frozen_string_literal: true

require "bundler/setup"
require "mechanize"
require "nokogiri"
require "open-uri"
require "byebug"
require "openssl"
require_relative "./contract"

I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module OpenLicitaciones
  class Parser
    def self.parse
      PageParser.new("https://contrataciondelestado.es/wps/portal/licRecientes").parse
    end
  end

  class PageParser
    def initialize(url)
      @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
      @url = url
      @uri = URI.parse(@url)
    end

    def parse
      @agent.get(@url) do |page|
        page.search(".tdidExpedienteWidth a").map{|h| h['href'] }.each do |href|
          parse_item @agent.click(page.link_with(:href => href))
        end
      end
    end

    def parse_item(item_page)
      ItemParser.new(item_page).parse
    end

    # def extract_links
    #   @agent.get(@url) do |page|
    #     return page.search(".tdidExpedienteWidth a").map{|h| h['href'] }
    #   end
    # end

    # def make_absolute_link(relative_link)
    #   uri = @uri.clone
    #   uri.path = relative_link
    #   uri.to_s
    # end
  end

  class ItemParser
    def initialize(item_page)
      @contract = Contract.new
      @page = item_page
    end

    def parse
      @contract.id = get_id
    end

    private

    def get_id
      @page.search("#fila0_columna0 span").last.text.strip
    end
  end
end


OpenLicitaciones::Parser.parse
