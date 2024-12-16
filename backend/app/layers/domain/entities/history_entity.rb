require_relative "../../shared_kernel/domain/entity"
require_relative "../../shared_kernel/domain/value_objects/uuid"
require_relative "../exceptions/history_exception"
require_relative "../validations/history_validation"
require_relative "../entities/student_entity"

module Domain
  module Entities
    class HistoryEntity < SharedKernel::Domain::Entity
      attribute :reference_date, SharedKernel::Domain::Types::Date
      attribute :final_grade, SharedKernel::Domain::Types::Float
      attribute :student, SharedKernel::Domain::Types.Instance(Domain::Entities::StudentEntity)

      def initialize(attributes)
        validation = Validations::HistoryValidation.new.call(attributes)
        raise Exceptions::HistoryException.new(validation.errors.to_h) unless validation.success?
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
          reference_date: reference_date,
          final_grade: final_grade,
          created_at: created_at,
          updated_at: updated_at,
          student: student.to_h
        }
      end
    end
  end
end
