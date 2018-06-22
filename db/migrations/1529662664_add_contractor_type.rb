# frozen_string_literal: true

Sequel.migration do
  change do
    add_column :contracts, :contractor_type, String
  end
end
