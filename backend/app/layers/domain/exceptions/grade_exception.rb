module Domain
  module Exceptions
    class GradeException < StandardError
      def initialize(messages)
        super("Grade validation failed: #{messages}")
      end
    end
  end
end
