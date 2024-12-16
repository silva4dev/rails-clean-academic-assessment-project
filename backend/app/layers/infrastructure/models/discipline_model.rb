require_relative "../../shared_kernel/infrastructure/application_record"

module Infrastructure
  module Models 
    class DisciplineModel < SharedKernel::Infrastructure::ApplicationRecord
      self.table_name = "disciplines"

      has_many :grades, class_name: "Infrastructure::Models::GradeModel"
      has_many :students, through: :grades, class_name: "Infrastructure::Models::StudentModel"
    
      validates :name, presence: true
      validates :days_interval, numericality: { greater_than_or_equal_to: 90, less_than_or_equal_to: 365 }, allow_nil: true

      def self.model_name
        ActiveModel::Name.new(self, nil, "discipline")
      end
    end
  end
end
