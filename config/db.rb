# frozen_string_literal: true

module OpenLicitaciones
  class DB
    def self.connection
      @connection ||= Sequel.connect(YAML.safe_load(ERB.new(File.read(File.expand_path("database.yml", __dir__))).result))
    end
  end
end
