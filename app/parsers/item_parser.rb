# frozen_string_literal: true

require_relative "../../config/application"

module OpenLicitaciones
  class ItemParser
    def initialize(item_page)
      @page = item_page
      @contract = Contract.new
    end

    def parse
      @contract.internal_id = SecureRandom.uuid
      @contract.id = get_id
      @contract.entity_name = get_entity
      @contract.contractor_name = get_contractor
      @contract.status = get_status
      @contract.title = get_title
      @contract.base_budget = get_base_budget
      @contract.contract_value = get_contract_value
      @contract.contract_type = get_contract_type
      @contract.cpvs = get_cpvs
      @contract.cpvs_divisions = get_cpvs_divisions
      @contract.cpvs_groups = get_cpvs_groups
      @contract.location = get_location
      @contract.hiring_procedure = get_hiring_procedure
      @contract.date_proposal = get_date_proposal
      @contract.permalink = get_permalink
      @contract.procedure_result = get_procedure_result
      @contract.assignee = get_assignee
      @contract.number_of_proposals = get_number_of_proposals
      @contract.final_amount = get_final_amount
      @contract.updated_at = Time.now
      @contract.published_at = get_published_at
      @contract
    end

    private

    def get_id
      id = @page.search("#fila0_columna0 span").last.text.strip
      entity = get_entity
      [entity, id].join("/")
    end

    def get_entity
      @page.search("#fila0 li span").text.split(">").last.strip
    end

    def get_contractor
      @page.search("#fila2_columna2 span").text.strip
    end

    def get_status
      @page.search("#fila3_columna2 span").text.strip
    end

    def get_title
      @page.search("#fila4_columna2 span").text.strip
    end

    def get_base_budget
      parse_money @page.search("#fila5_columna2 span").text.strip
    end

    def get_contract_value
      parse_money @page.search("#fila6_columna2 span").text.strip
    end

    def get_contract_type
      @page.search("#fila7_columna2 span").text.strip
    end

    def get_cpvs
      @page.search("#fila8_columna2 span").text.strip.split(",").map do |cpv_str|
        if (m = cpv_str.match(/(\d+)/))
          m[0].strip
        end
      end.compact
    rescue StandardError
      puts $ERROR_INFO
      puts @page.search("#fila8_columna2 span").text.strip
      []
    end

    def get_cpvs_divisions
      get_cpvs.map do |cpv|
        cpv[0..2] + "00000"
      end.sort.uniq
    end

    def get_cpvs_groups
      get_cpvs.map do |cpv|
        cpv[0..3] + "0000"
      end.sort.uniq
    end

    def get_location
      @page.search("#fila9_columna2 span").text.strip
    end

    def get_hiring_procedure
      @page.search("#fila10_columna2 span").text.strip
    end

    def get_date_proposal
      s = @page.search("#fila12_1_columna2 span").text.strip
      Time.parse(s, "%d/%m/%Y %H:%M")
    rescue StandardError
      nil
    end

    def get_permalink
      if !@page.search("#fila18_columna2_1 span").empty?
        @page.search("#fila18_columna2_1 span").text.strip
      else
        @page.search("#fila18_columna2_2 span").text.strip
      end
    end

    def get_procedure_result
      @page.search("#fila13_columna2 span").text.strip
    end

    def get_assignee
      @page.search("#fila14_columna2 span").text.strip
    end

    def get_number_of_proposals
      @page.search("#fila15_columna2 span").text.strip.to_i
    end

    def get_final_amount
      parse_money @page.search("#fila16_columna2 span").text.strip
    end

    def parse_money(x)
      x.tr(",", "").to_f
    end

    def get_published_at
      s = @page.search("table.dataTableEx tbody tr.rowClass1 td.padding0punto2").text.strip
      Date.parse(s, "%d/%m/%Y")
    rescue StandardError
      nil
    end
  end
end
