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
require_relative "../app/models/feed_parser"
require_relative "../app/models/history_parser"

# Chewy indexes
require_relative "../app/chewy/contracts_index"

# Constants
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

