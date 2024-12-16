require_relative "../../shared_kernel/application/service"
require_relative "../../infrastructure/repositories/student_repository"
require_relative "../../infrastructure/repositories/grade_repository"
require_relative "../../infrastructure/repositories/discipline_repository"

module Application
  module Services
    class GetStudentGradesService < SharedKernel::Application::Service 
      def initialize(repositories = {})
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new }
        @grade_repository = repositories.fetch(:grade) { Infrastructure::Repositories::GradeRepository.new }
        @discipline_repository = repositories.fetch(:discipline) { Infrastructure::Repositories::DisciplineRepository.new }
      end
    
      def execute(input_dto)
        student = @student_repository.find_by_id(input_dto.student_id)
        return Failure({ error: "Student with id #{input_dto.student_id} not found", code: 404 }) unless student
        grades = @grade_repository.find_by_student_id_with_disciplines(input_dto.student_id)
        if grades.empty?
          return Failure({ error: "No grades found for student with id #{input_dto.student_id}", code: 404 })
        end
      end
    end
  end
end
