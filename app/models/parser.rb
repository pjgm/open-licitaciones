# frozen_string_literal: true

require_relative "../../config/boot"

I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module OpenLicitaciones
  class Parser
    def self.parse(npages = 5)
      url = "https://contrataciondelestado.es/wps/portal/licRecientes"
      @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
      contracts = PageParser.new(url, @agent).parse
      Importer.import(contracts)
      next_link = get_next_link(url)

      npages.times do |i|
        contracts = PageParser.new(next_link, @agent).parse
        Importer.import(contracts)
        next_link = get_next_link(next_link)
      end
    end

    def self.get_next_link(url)
      @agent.get(url) do |page|
        form = page.forms.first
        button = form.button_with(value: "Next >>")
        new_page = @agent.submit(form, button)
        return new_page.uri.to_s
      end
    end
  end
end
