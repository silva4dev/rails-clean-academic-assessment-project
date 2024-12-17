require_relative "../../domain/repositories/history_repository"
require_relative "../models/history_model"
require_relative "../mappers/get_histories_mapper"
require_relative "../mappers/get_top_students_mapper"

module Infrastructure
  module Repositories
    class HistoryRepository < Domain::Repositories::HistoryRepository
      def get_histories_by_student(id)
        Models::HistoryModel
          .where(student_id: id)
          .map { |history| Mappers::GetHistoriesMapper.to_entity(history) }
      end

      def get_histories_by_reference_date(start_date, end_date)
        Models::HistoryModel
          .where(reference_date: start_date..end_date)
          .order(final_grade: :desc)
          .map { |history| Mappers::GetTopStudentsMapper.to_entity(history) }
      end

      def create(input)
        Models::HistoryModel.new(input.to_h).save!
      end
    end
  end
end
