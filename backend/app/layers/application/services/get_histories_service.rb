require_relative "../../shared_kernel/application/service"
require_relative "../../domain/entities/grade_entity"
require_relative "../../infrastructure/repositories/student_repository"
require_relative "../../infrastructure/repositories/history_repository"

module Application
  module Services
    class GetHistoriesService < SharedKernel::Application::Service 
      def initialize(repositories = {})
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new } 
        @history_repository = repositories.fetch(:history) { Infrastructure::Repositories::HistoryRepository.new }
        @logger = Rails.logger 
      end
    
      def execute(input_dto)
        @logger.info "Fetching histories for student with id: #{input_dto.student_id}"
        student = @student_repository.find_by_id(input_dto.student_id)
        unless student
          @logger.error "Student with id #{input_dto.student_id} not found"
          return Failure({ error: "Student with id #{input_dto.student_id} not found", code: 404 })
        end
        histories = @history_repository.get_histories_by_student(input_dto.student_id)
        @logger.info "#{histories.count} histories found for student id #{input_dto.student_id}"
        Success({ histories: histories.map { |history| history.to_h }, code: 200 })
      end
    end
  end
end
