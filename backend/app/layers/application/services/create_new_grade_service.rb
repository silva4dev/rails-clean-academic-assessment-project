require_relative "../../shared_kernel/application/service"
require_relative "../../domain/entities/grade_entity"
require_relative "../../infrastructure/repositories/student_repository"
require_relative "../../infrastructure/repositories/grade_repository"
require_relative "../../infrastructure/repositories/discipline_repository"

module Application
  module Services
    class CreateNewGradeService < SharedKernel::Application::Service 
      def initialize(repositories = {})
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new } 
        @grade_repository = repositories.fetch(:grade) { Infrastructure::Repositories::GradeRepository.new }
        @discipline_repository = repositories.fetch(:discipline) { Infrastructure::Repositories::DisciplineRepository.new }
        @logger = Rails.logger
      end
    
      def execute(input_dto)
        @logger.info "Attempting to create new grade for student with id: #{input_dto.student_id}, discipline id: #{input_dto.discipline_id}"
        student = @student_repository.find_by_id(input_dto.student_id)
        unless student
          @logger.error "Student with id #{input_dto.student_id} not found"
          return Failure({ error: "Student with id #{input_dto.student_id} not found", code: 404 })
        end
        discipline = @discipline_repository.find_by_id(input_dto.discipline_id)
        unless discipline
          @logger.error "Discipline with id #{input_dto.discipline_id} not found"
          return Failure({ error: "Discipline with id #{input_dto.discipline_id} not found", code: 404 })
        end
        grade = Domain::Entities::GradeEntity.new(
          student_id: student.id,
          discipline_id: discipline.id,
          value: input_dto.value,
          created_at: Time.now,
          updated_at: nil
        )
        if @grade_repository.create(grade)
          @logger.info "Grade successfully created for student #{student.id}, discipline #{discipline.id}"
          Success({ message: "Grade successfully created!", code: 201 })
        else
          @logger.error "Failed to create grade for student #{student.id}, discipline #{discipline.id}"
          Failure({ error: "Failed to create grade!", code: 422 })
        end
      end
    end
  end
end
