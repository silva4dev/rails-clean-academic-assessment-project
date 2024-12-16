module Domain
  module Exceptions
    class StudentException < StandardError
      def initialize(messages)
        super("Student validation failed: #{messages}")
      end
    end
  end
end
