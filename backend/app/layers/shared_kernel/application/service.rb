require "dry-monads"

module SharedKernel
  module Application
    class Service
      include Dry::Monads[:result]

      def call(input_dto = {})
        raise NotImplementedError
      end
    end
  end
end
