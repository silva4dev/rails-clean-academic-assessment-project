module Domain
  module Repositories
    class GradeRepository
      def create(input)
        raise NotImplementedError
      end
      
      def get_latest_grades_by_student(id)
        raise NotImplementedError
      end

      def get_final_grade_by_student(id)
        raise NotImplementedError
      end
    end
  end
end
