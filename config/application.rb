# frozen_string_literal: true

require_relative "./boot"
require_relative "./db"

Sequel::Model.db = OpenLicitaciones::DB.connection
Sequel::Model.db.extension(:pg_array)

# Models
require_relative "../app/models/contract"
require_relative "../app/parsers/item_parser"
require_relative "../app/parsers/page_parser"
require_relative "../app/models/importer"
require_relative "../app/operations/parse_feed"
require_relative "../app/operations/parse_sitemap"

# Chewy indexes
require_relative "../app/chewy/contracts_index"

# Constants
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
