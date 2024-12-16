require_relative "../../shared_kernel/domain/validation"
require_relative "../../shared_kernel/domain/types"

module Domain
  module Validations
    class StudentValidation < SharedKernel::Domain::Validation
      params do
        required(:name).filled(:string)
      end
    end
  end
end
