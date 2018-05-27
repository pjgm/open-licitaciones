# frozen_string_literal: true

require_relative "./boot"
require_relative "./db"

Sequel::Model.db = OpenLicitaciones::DB.connection
Sequel::Model.db.extension(:pg_array)

# Models
require_relative "../app/models/contract"
require_relative "../app/models/item_parser"
require_relative "../app/models/page_parser"
require_relative "../app/models/importer"
require_relative "../app/models/parser"

# Chewy indexes
require_relative "../app/chewy/contracts_index"
