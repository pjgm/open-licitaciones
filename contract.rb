# frozen_string_literal: true

require "bundler/setup"
require "virtus"

module OpenLicitaciones
  class Contract
    include Virtus.model

    attribute :id, String
  end
end
