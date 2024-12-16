require_relative "../../shared_kernel/domain/entity"
require_relative "../../shared_kernel/domain/value_objects/uuid"
require_relative "../exceptions/grade_exception"
require_relative "../validations/grade_validation"

module Domain
  module Entities
    class GradeEntity < SharedKernel::Domain::Entity
      attribute :student_id, SharedKernel::Domain::Types::String
      attribute :discipline_id, SharedKernel::Domain::Types::String
      attribute :value, SharedKernel::Domain::Types::Float

      def initialize(attributes)
        validation = Validations::GradeValidation.new.call(attributes)
        raise Exceptions::GradeException.new(validation.errors.to_h) unless validation.success?
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
          student_id: student_id,
          discipline_id: discipline_id,
          value: value,
          created_at: created_at,
          updated_at: updated_at
        }
      end
    end
  end
end
