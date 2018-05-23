# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup"
require "open-uri"
require "openssl"
require "securerandom"

Bundler.require

# Models
require_relative "../app/models/contract"
require_relative "../app/models/item_parser"
require_relative "../app/models/page_parser"
require_relative "../app/models/importer"
require_relative "../app/models/parser"

# Chewy indexes
require_relative "../app/chewy/contracts_index"
