require_relative "../../shared_kernel/domain/entity"
require_relative "../../shared_kernel/domain/value_objects/uuid"
require_relative "../exceptions/discipline_exception"
require_relative "../validations/discipline_validation"

module Domain
  module Entities
    class DisciplineEntity < SharedKernel::Domain::Entity
      attribute :name, SharedKernel::Domain::Types::String
      attribute :days_interval, SharedKernel::Domain::Types::Integer.optional

      def initialize(attributes)
        validation = Validations::DisciplineValidation.new.call(attributes)
        raise Exceptions::DisciplineException.new(validation.errors.to_h) unless validation.success?
        attributes[:id] ||= if attributes[:id].is_a?(String)
          SharedKernel::Domain::ValueObjects::Uuid.new(value: attributes[:id])
        else
          SharedKernel::Domain::ValueObjects::Uuid.new
        end
        super(attributes)
      end

      def to_h
        {
          id: id,
          name: name,
          days_interval: days_interval,
          created_at: created_at,
          updated_at: updated_at
        }
      end
    end
  end
end
