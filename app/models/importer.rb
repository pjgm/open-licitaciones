# frozen_string_literal: true

require_relative "../../config/application"

module OpenLicitaciones
  class Importer
    def self.import(contracts)
      contracts.each do |contract|
        save(contract)
      end
    end

    def self.save(contract)
      if ContractsIndex::Contract.import contract
        puts "- [OK - ES] Imported contract #{contract.id}"
      end

      if existing_contract = Contract.where(id: contract.id).first
        existing_contract.set contract.values.except(:id)
        existing_contract.save
      else
        contract.save
      end
      puts "- [OK - DB] #{existing_contract ? "Updated" : "Imported"} contract #{contract.id}"
    rescue
      puts "- [KO] #{$!}"
    end
  end
end
