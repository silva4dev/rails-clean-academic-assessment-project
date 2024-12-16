require_relative "../../shared_kernel/infrastructure/application_record"

module Infrastructure
  module Models
    class HistoryModel < SharedKernel::Infrastructure::ApplicationRecord
      self.table_name = "histories"

      belongs_to :student, class_name: "Infrastructure::Models::StudentModel"
    
      validates :reference_date, presence: true
      validates :final_grade, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    
      def self.model_name
        ActiveModel::Name.new(self, nil, "history")
      end
    end
  end
end
