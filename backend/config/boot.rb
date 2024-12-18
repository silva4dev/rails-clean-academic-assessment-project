ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
ENV["PORT"] = "5000"

require "bundler/setup"
require "bootsnap/setup"
