require_relative "../../shared_kernel/application/service"
require_relative "../../infrastructure/repositories/student_repository"
require_relative "../../infrastructure/repositories/grade_repository"

module Application
  module Services
    class GetStudentClosestToMaxGradeService < SharedKernel::Application::Service
      def initialize(repositories = {})
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new }
        @grade_repository = repositories.fetch(:grade) { Infrastructure::Repositories::GradeRepository.new }
        @logger = Rails.logger
      end

      def execute
        @logger.info "Fetching all students to calculate who is closest to max grade"
        students = @student_repository.get_students
        return Failure({ error: "No students found", code: 404 }) if students.empty?
        closest_student = nil
        highest_grade = -Float::INFINITY
        students.each do |student|
          final_grade = @grade_repository.get_final_grade_by_student(student.id)
          next unless final_grade
          if final_grade > highest_grade
            highest_grade = final_grade
            closest_student = student
          end
        end
        if closest_student
          Success({
            data: {
              id: closest_student.id,
              name: closest_student.name,
              final_grade: highest_grade.to_f.round(2)
            },
            code: 200
          })
        else
          Failure({ error: "No grades found for students", code: 404 })
        end
      end
    end
  end
end
