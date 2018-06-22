# frozen_string_literal: true

Sequel.migration do
  up do
    extension :pg_array

    create_table(:contracts) do
      String :id, primary_key: true
      String :internal_id, null: false, unique: true
      String :permalink, null: false, unique: true
      String :entity_name, null: false
      String :contractor_name, null: false
      String :status, null: false
      String :title, null: false
      Float :base_budget
      Float :contract_value
      String :contract_type
      column "cpvs", "text[]" # PostgreSql Array
      String :location
      String :hiring_procedure
      Date :date_proposal
      String :procedure_result
      String :assignee
      Integer :number_of_proposals
      Float :final_amount
      DateTime :updated_at
    end
  end

  down do
    drop_table(:contracts)
  end
end
