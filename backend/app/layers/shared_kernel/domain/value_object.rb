require "dry-struct"

module SharedKernel
  module Domain
    class ValueObject < Dry::Struct::Value; end
  end
end
