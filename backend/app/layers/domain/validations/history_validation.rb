require_relative "../../shared_kernel/domain/validation"
require_relative "../../shared_kernel/domain/types"

module Domain
  module Validations
    class HistoryValidation < SharedKernel::Domain::Validation
      params do
        required(:reference_date).filled(:date)
        required(:final_grade).filled(:float, gteq?: 0, lteq?: 100)
        required(:student).filled
      end
    end
  end
end
