# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup"
require "erb"
require "open-uri"
require "openssl"
require "securerandom"
require "yaml"
require "erb"

Bundler.require
