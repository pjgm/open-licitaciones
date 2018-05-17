# frozen_string_literal: true

require "bundler/setup"
require "mechanize"
require "nokogiri"
require "open-uri"
require "byebug"
require "openssl"
require "securerandom"
require_relative "./page_parser"

I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module OpenLicitaciones
  class Parser
    def self.parse
      url = "https://contrataciondelestado.es/wps/portal/licRecientes"
      PageParser.new(url).parse
      next_link = get_next_link(url)

      5.times do |i|
        puts "Iteration #{i}"
        PageParser.new(next_link).parse
        next_link = get_next_link(next_link)
      end
    end

    def self.get_next_link(url)
      agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
      agent.get(url) do |page|
        form = page.forms.first
        button = form.button_with(value: "Next >>")
        new_page = agent.submit(form, button)
        return new_page.uri.to_s
      end
    end
  end
end


OpenLicitaciones::Parser.parse
