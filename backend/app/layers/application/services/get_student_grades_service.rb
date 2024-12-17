require_relative "../../shared_kernel/application/service"
require_relative "../../infrastructure/repositories/student_repository"
require_relative "../../infrastructure/repositories/grade_repository"

module Application
  module Services
    class GetStudentGradesService < SharedKernel::Application::Service 
      def initialize(repositories = {})
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new }
        @grade_repository = repositories.fetch(:grade) { Infrastructure::Repositories::GradeRepository.new }
        @logger = Rails.logger
      end
    
      def execute(input_dto)
        @logger.info "Fetching grades for student with id: #{input_dto.student_id}"
        student = @student_repository.find_by_id(input_dto.student_id)
        unless student
          @logger.error "Student with id #{input_dto.student_id} not found"
          return Failure({ error: "Student with id #{input_dto.student_id} not found", code: 404 })
        end
        grades = @grade_repository.get_latest_grades_by_student(input_dto.student_id)
        if grades.empty?
          @logger.error "No grades found for student with id #{input_dto.student_id}"
          return Failure({ error: "No grades found for student with id #{input_dto.student_id}", code: 404 })
        end
        final_grade = @grade_repository.get_final_grade_by_student(input_dto.student_id)
        @logger.info "Final grade calculated: #{final_grade.to_f.round(2)}"
        Success({
          data: {
            id: student.id,
            name: student.name,
            grades: grades,
            final_grade: final_grade.to_f.round(2)
          },
          code: 200
        })
      end
    end
  end
end
