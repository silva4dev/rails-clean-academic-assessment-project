module Domain
  module Repositories
    class GradeRepository
      def create(input)
        raise NotImplementedError
      end
      
      def find_by_student_id_with_disciplines(id)
        raise NotImplementedError
      end
    end
  end
end
