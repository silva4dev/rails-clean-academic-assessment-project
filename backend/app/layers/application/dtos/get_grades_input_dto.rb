require_relative "../../shared_kernel/domain/validation"

module Application
  module Dtos
    class GetGradesInputDto < Dry::Struct
      attribute :student_id, SharedKernel::Domain::Types::String

      def to_h
        { 
          student_id: student_id
        }
      end
    end
  end
end
