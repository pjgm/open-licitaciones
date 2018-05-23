# frozen_string_literal: true

class ContractsIndex < Chewy::Index
  define_type OpenLicitaciones::Contract do
    field :id, type: "string"
    field :internal_id, type: "string", index: "not_analyzed"
    field :permalink, type: "string", index: "not_analyzed"
    field :entity_name, type: "string"
    field :contractor_name, type: "string"
    field :status, type: "string", index: "not_analyzed"
    field :title, type: "string"
    field :base_budget, type: "float"
    field :contract_value, type: "float"
    field :contract_type, type: "string", index: "not_analyzed"
    field :cpvs, type: "string", index: "not_analyzed"
    field :location, type: "string", index: "not_analyzed"
    field :hiring_procedure, type: "string", index: "not_analyzed"
    field :date_proposal, type: "date"
    field :procedure_result, type: "string", index: "not_analyzed"
    field :assignee, type: "string", index: "not_analyzed"
    field :number_of_proposals, type: "integer"
    field :final_amount, type: "float"
    field :updated_at, type: "date"
  end
end
