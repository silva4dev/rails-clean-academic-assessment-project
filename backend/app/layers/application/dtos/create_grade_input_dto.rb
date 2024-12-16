require_relative "../../shared_kernel/domain/validation"

module Application 
  module Dtos 
    class CreateGradeInputDto < Dry::Struct
      attribute :student_id, SharedKernel::Domain::Types::String
      attribute :discipline_id, SharedKernel::Domain::Types::String
      attribute :value, SharedKernel::Domain::Types::Coercible::Float

      def to_h
        { 
          student_id: student_id, 
          discipline_id: discipline_id, 
          value: value 
        }
      end
    end
  end
end
