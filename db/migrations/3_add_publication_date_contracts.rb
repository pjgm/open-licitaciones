# frozen_string_literal: true

Sequel.migration do
  up do
    add_column :contracts, :published_at, :date
  end

  down do
    remove_column :contracts, :published_at
  end
end
