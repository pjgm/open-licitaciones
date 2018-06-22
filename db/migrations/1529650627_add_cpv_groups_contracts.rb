# frozen_string_literal: true

Sequel.migration do
  up do
    extension :pg_array
    add_column :contracts, :cpvs_groups, "text[]"
  end

  down do
    remove_column :contracts, :cpvs_groups
  end
end
