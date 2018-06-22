# frozen_string_literal: true

require_relative "./config/application"
require "sequel/rake"
Sequel::Rake.load!

Sequel::Rake.configure do
  set :connection, OpenLicitaciones::DB.connection
end
