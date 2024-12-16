require "dry-monads"

require_relative "./types"

module SharedKernel
  module Domain
    class Entity < Dry::Struct
      include Dry::Monads[:result]

      attribute :id, Domain::Types::String.optional.default(nil)
      attribute :created_at, Domain::Types::Time.optional
      attribute :updated_at, Domain::Types::Time.optional
    end
  end
end
