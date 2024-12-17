require_relative "../../shared_kernel/application/service"
require_relative "../../infrastructure/repositories/student_repository"
require_relative "../../infrastructure/repositories/grade_repository"

module Application
  module Services
    class GetStudentGradesService < SharedKernel::Application::Service 
      def initialize(repositories = {})
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new }
        @grade_repository = repositories.fetch(:grade) { Infrastructure::Repositories::GradeRepository.new }
      end
    
      def execute(input_dto)
        student = @student_repository.find_by_id(input_dto.student_id)
        return Failure({ error: "Student with id #{input_dto.student_id} not found", code: 404 }) unless student
        grades = @grade_repository.get_latest_grades_by_student(input_dto.student_id)
        return Failure({ error: "No grades found for student with id #{input_dto.student_id}", code: 404 }) if grades.empty?
        final_grade = @grade_repository.get_final_grade_by_student(input_dto.student_id)
        Success({
          data: {
            id: student.id,
            name: student.name,
            grades: grades,
            final_grade: final_grade.round(2)
          },
          code: 200
        })
      end
    end
  end
end
