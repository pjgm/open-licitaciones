# frozen_string_literal: true

Sequel.migration do
  up do
    extension :pg_array
    add_column :contracts, :cpvs_divisions, "text[]"
  end

  down do
    remove_column :contracts, :cpvs_divisions
  end
end
