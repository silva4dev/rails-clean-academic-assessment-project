module Domain
  module Repositories
    class StudentRepository
      def find_by_id(id)
        raise NotImplementedError
      end

      def get_students
        raise NotImplementedError
      end
    end
  end
end
