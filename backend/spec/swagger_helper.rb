require "rails_helper"

RSpec.configure do |config|
  config.openapi_root = Rails.root.join("swagger").to_s
  config.openapi_specs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "Academic Assessment",
        description: "Building application for performance academic.",
        version: "v1",
        "x-author": "Lucas Alves"
      },
      paths: {},
      servers: [
        {
          url: "http://#{ENV['HOST'] || 'localhost'}:#{ENV['PORT'] || 3000}"
        }
      ]
    }
  }
  config.openapi_format = :yaml
end
