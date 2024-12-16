require_relative "../../shared_kernel/domain/validation"
require_relative "../../shared_kernel/domain/types"

module Domain
  module Validations
    class GradeValidation < SharedKernel::Domain::Validation
      params do
        required(:student_id).filled(:string)
        required(:discipline_id).filled(:string)
        required(:value).filled(:float, gteq?: 0, lteq?: 100)
      end
    end
  end
end
