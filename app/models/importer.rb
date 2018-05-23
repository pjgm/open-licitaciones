# frozen_string_literal: true

require_relative "../../config/boot"

module OpenLicitaciones
  class Importer
    def self.import(contracts)
      contracts.each do |contract|
        begin
          existing_contract = ContractsIndex::Contract.find(contract.id)
          if existing_contract.attributes.except(:updated_at, :internal_id) != contract.attributes.except(:updated_at, :internal_id)
            save(contract, existing_contract)
          else
            puts "- [OK] Skipped contract #{contract.id}"
          end
        rescue Chewy::DocumentNotFound
          save(contract)
        end
      end
    end

    def self.save(contract, existing_contract = false)
      if ContractsIndex::Contract.import contract
        puts "- [OK] #{existing_contract ? "Updated" : "Imported"} contract #{contract.id}"
      end
    end
  end
end
