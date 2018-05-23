# frozen_string_literal: true

require_relative "../../config/boot"

module OpenLicitaciones
  class Contract
    include Virtus.model

    attribute :id, String
    attribute :internal_id, String
    attribute :permalink, String
    attribute :entity_name, String
    attribute :contractor_name, String
    attribute :status, String
    attribute :title, String
    attribute :base_budget, Float
    attribute :contract_value, Float
    attribute :contract_type, String
    attribute :cpvs, Array[Integer]
    attribute :location, String
    attribute :hiring_procedure, String
    attribute :date_proposal, DateTime
    attribute :procedure_result, String
    attribute :assignee, String
    attribute :number_of_proposals, Integer
    attribute :final_amount, Float
    attribute :updated_at, DateTime
  end
end
