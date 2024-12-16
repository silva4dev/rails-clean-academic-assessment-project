require_relative "../../shared_kernel/domain/validation"
require_relative "../../shared_kernel/domain/types"

module Domain
  module Validations
    class DisciplineValidation < SharedKernel::Domain::Validation
      params do
        required(:name).filled(:string)
        optional(:days_interval).maybe(:int?, gteq?: 90, lteq?: 365)
      end
    end
  end
end
  