# frozen_string_literal: true

Sequel.migration do
  change do
    add_column :contracts, :municipality_id, String
    add_column :contracts, :municipality_name, String
    add_column :contracts, :province_id, String
    add_column :contracts, :province_name, String
    add_column :contracts, :autonomous_region_id, String
    add_column :contracts, :autonomous_region_name, String
  end
end
