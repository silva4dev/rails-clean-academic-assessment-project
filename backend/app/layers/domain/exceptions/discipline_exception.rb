module Domain
  module Exceptions
    class DisciplineException < StandardError
      def initialize(messages)
        super("Discipline validation failed: #{messages}")
      end
    end
  end
end
