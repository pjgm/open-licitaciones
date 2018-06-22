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
      # Disable temporally Elastic search
      # if ContractsIndex::Contract.import contract
      #   puts "- [OK - ES] Imported contract #{contract.id}"
      # end

      if (existing_contract = Contract.where(id: contract.id).first)
        new_values = contract.values
        except_keys = new_values.select { |_k, v| v.nil? }.keys + [:id]
        new_values = contract.values.except(*except_keys)
        existing_contract.set new_values
        existing_contract.save
      else
        contract.save
      end
      puts "- [OK - DB] #{existing_contract ? "Updated" : "Imported"} contract #{contract.id}"
    rescue StandardError
      puts "- [KO] #{$ERROR_INFO}"
    end
  end
end
