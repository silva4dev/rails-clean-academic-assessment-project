require_relative "../../shared_kernel/domain/validation"

module Application 
  module Dtos 
    class GetTopStudentsInputDto < Dry::Struct
      attribute :start_date, SharedKernel::Domain::Types::Date
      attribute :end_date, SharedKernel::Domain::Types::Date

      def to_h
        { 
          start_date: month, 
          end_date: year 
        }
      end
    end
  end
end
