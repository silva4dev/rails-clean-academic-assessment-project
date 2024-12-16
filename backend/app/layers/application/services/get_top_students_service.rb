require_relative "../../shared_kernel/application/service"
require_relative "../../infrastructure/repositories/history_repository"
require_relative "../../infrastructure/repositories/student_repository"

module Application
  module Services
    class GetTopStudentsService < SharedKernel::Application::Service 
      def initialize(repositories = {})
        @history_repository = repositories.fetch(:history) { Infrastructure::Repositories::HistoryRepository.new }
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new }
      end
    
      def execute(input_dto)
        histories = @history_repository.get_histories_by_reference_date(input_dto.start_date, input_dto.end_date)
        return Failure({ error: "No histories found for the last month", code: 404 }) if histories.empty?
        Success({ histories: histories.map { |history| history.to_h }, code: 200 })
      end
    end
  end
end
