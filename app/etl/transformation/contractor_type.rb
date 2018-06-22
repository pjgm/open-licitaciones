# frozen_string_literal: true

require_relative "../../../config/application"

module OpenLicitaciones
  module ETL
    module Transformation
      class ContractorType
        def initialize
          @types = ['Ayuntamiento', 'Diputacion']
          @transformations = {
            'ayuntamiento' => 'Ayuntamiento',
            'concello' => 'Ayuntamiento',
            'diputacion' => 'Diputacion',
            'ajuntament' => 'Ayuntamiento',
            'diputacio' => 'Diputacion',
          }
        end

        def classify(name)
          name.split(/\s/).each do |word|
            tword = tokenize(word)
            if @transformations.has_key?(tword)
              return @transformations[tword]
            else
              next
            end
          end
          return nil
        end

        private

        def tokenize(str)
          str.downcase.strip.tr(".", "").tr(",", "").tr("l'", " ").tr("d'", " ").gsub(/el|las|la|los|del|de/, "").parameterize
        end
      end
    end
  end
end
