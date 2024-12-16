require "dry-validation"

require_relative "./types"

module SharedKernel
  module Domain
    class Validation < Dry::Validation::Contract
      params do
        optional(:created_at).maybe(SharedKernel::Domain::Types::Time)
        optional(:updated_at).maybe(SharedKernel::Domain::Types::Time)
      end
    end
  end
end
