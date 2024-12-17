require_relative "../../domain/repositories/grade_repository"
require_relative "../models/grade_model"
require_relative "../mappers/get_student_grades_mapper"

module Infrastructure
  module Repositories
    class GradeRepository < Domain::Repositories::GradeRepository
      def create(input)
        Models::GradeModel.new(input.to_h).save!
      end

      def get_latest_grades_by_student(id)
        Models::GradeModel
          .joins(:discipline)
          .select("grades.*, disciplines.name")
          .where(student_id: id)
          .where(
            "grades.created_at IN (
              SELECT MAX(grades.created_at)
              FROM grades
              WHERE grades.student_id = ?
              GROUP BY grades.discipline_id
            )", id
          )
          .order("disciplines.name ASC")
          .map { |grade| Infrastructure::Mappers::GetStudentGradesMapper.to_dao(grade) }
      end

      def get_final_grade_by_student(id)
        grades = Models::GradeModel
          .includes(:discipline)
          .where(student_id: id)
          .map { |grade| Infrastructure::Mappers::GetStudentGradesMapper.to_dao(grade) }
        
        grades.map { |grade| grade[:value] }.sum / grades.size
      end
    end
  end
end
