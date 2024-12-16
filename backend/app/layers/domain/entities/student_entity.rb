require_relative "../../shared_kernel/domain/entity"
require_relative "../../shared_kernel/domain/value_objects/uuid"
require_relative "../exceptions/student_exception"
require_relative "../validations/student_validation"

module Domain
  module Entities
    class StudentEntity < SharedKernel::Domain::Entity
      attribute :name, SharedKernel::Domain::Types::String

      def initialize(attributes)
        validation = Validations::StudentValidation.new.call(attributes)
        raise Exceptions::StudentException.new(validation.errors.to_h) unless validation.success?
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
          created_at: created_at,
          updated_at: updated_at
        }
      end
    end
  end
end
