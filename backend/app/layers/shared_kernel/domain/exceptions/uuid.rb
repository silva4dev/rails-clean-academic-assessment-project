module SharedKernel
  module Domain
    module Exceptions
      class Uuid < StandardError
        def initialize(message)
          super(message)
        end
      end
    end
  end
end
