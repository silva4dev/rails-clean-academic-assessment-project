require "dry-struct"

module SharedKernel
  module Domain
    module Types
      include Dry::Types()

      Time = Strict::Time.optional
    end
  end
end
