module Domain
  module Exceptions
    class HistoryException < StandardError
      def initialize(messages)
        super("History validation failed: #{messages}")
      end
    end
  end
end
