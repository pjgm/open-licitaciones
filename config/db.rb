# frozen_string_literal: true

module OpenLicitaciones
  class DB
    def self.connection
      @connection ||= Sequel.connect(YAML.load(ERB.new(File.read(File.expand_path('../database.yml', __FILE__))).result))
    end
  end
end

