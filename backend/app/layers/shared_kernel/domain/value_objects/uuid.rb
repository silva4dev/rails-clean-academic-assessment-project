require "uuid"

require_relative "../value_object"
require_relative "../types"
require_relative "../exceptions/uuid"

module SharedKernel
  module Domain
    module ValueObjects
      class Uuid < ValueObject
        attribute :value, SharedKernel::Domain::Types::String.optional.default(nil)

        def initialize(attributes = {})
          attributes[:value] ||= UUID.new.generate
          super(attributes)
          raise Exceptions::Uuid.new("Invalid UUID format") unless valid_uuid?(value)
        end

        private

        def valid_uuid?(uuid)
          uuid.is_a?(String) && uuid.match?(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/)
        end
      end
    end
  end
end
