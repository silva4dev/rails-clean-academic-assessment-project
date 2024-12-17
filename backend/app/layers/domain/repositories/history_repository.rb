module Domain
  module Repositories
    class HistoryRepository
      def get_histories_by_student(id)
        raise NotImplementedError
      end

      def get_histories_by_reference_date(start_date, end_date)
        raise NotImplementedError
      end

      def create(input)
        raise NotImplementedError
      end
    end
  end
end
