# frozen_string_literal: true

require_relative "../../../config/application"

module OpenLicitaciones
  module ETL
    module Transformation
      class GeoInformation
        def initialize
          @municipalities = INE::Places::Place.all
          @municipalities_reverse_table = Hash[@municipalities.map do |m|
            [m.name.parameterize, m.id]
          end]

          @matcher = FuzzyMatch.new(@municipalities_reverse_table.keys)
        end

        def find(str)
          candidate_name, score1, score2 = @matcher.find_with_score(str)
          place = INE::Places::Place.find(@municipalities_reverse_table[candidate_name])
          if score1 + score2 > 0.5 && tokenize(str).include?(tokenize(place.name))
            return place
          end
        end

        private

        def tokenize(str)
          str.downcase.strip.tr(".", "").tr(",", "").gsub(/el|las|la|los|del|de/, "").parameterize
        end
      end
    end
  end
end
