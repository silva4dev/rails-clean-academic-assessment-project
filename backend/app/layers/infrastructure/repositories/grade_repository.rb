require_relative "../../domain/repositories/grade_repository"
require_relative "../models/grade_model"

module Infrastructure
  module Repositories
    class GradeRepository < Domain::Repositories::GradeRepository
      def create(input)
        Models::GradeModel.new(input.to_h).save!
      end
    
      def find_by_student_id_with_disciplines(id)
        Models::GradeModel.includes(:discipline).where(student_id: id).map
      end
    end
  end
end
