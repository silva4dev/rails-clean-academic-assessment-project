require_relative "../../shared_kernel/application/service"
require_relative "../../infrastructure/repositories/student_repository"
require_relative "../../infrastructure/repositories/grade_repository"
require_relative "../../infrastructure/repositories/history_repository"
require_relative "../../domain/entities/history_entity"
require_relative "../../domain/entities/student_entity"

module Application
  module Services
    class MonthlyClosureService < SharedKernel::Application::Service
      def initialize(repositories = {})
        @student_repository = repositories.fetch(:student) { Infrastructure::Repositories::StudentRepository.new }
        @grade_repository = repositories.fetch(:grade) { Infrastructure::Repositories::GradeRepository.new }
        @history_repository = repositories.fetch(:history) { Infrastructure::Repositories::HistoryRepository.new }
        @logger = Rails.logger
      end

      def execute
        @logger.info "Starting monthly closure process..."
        students = @student_repository.get_students
        if students.empty?
          @logger.error "No students found."
          return Failure({ error: "No students found", code: 404 })
        end
        histories = []
        students.each do |student|
          @logger.info "Processing student: #{student.name} (ID: #{student.id})"
          final_grade = @grade_repository.get_final_grade_by_student(student.id)
          reference_date = Date.today.prev_month.end_of_month
          history = Domain::Entities::HistoryEntity.new(
            reference_date: reference_date,
            final_grade: final_grade,
            student: Domain::Entities::StudentEntity.new(
              id: student.id,
              name: student.name,
            )
          )
          @history_repository.create(history)
          histories << history
          @logger.info "History created for student: #{student.name}"
        end
        @logger.info "Monthly closure process completed for #{histories.count} students."
        Success({ histories: histories, code: 200 })
      end
    end
  end
end
