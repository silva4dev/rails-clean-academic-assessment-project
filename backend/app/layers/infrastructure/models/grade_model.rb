require_relative "../../shared_kernel/infrastructure/application_record"

module Infrastructure
  module Models
    class GradeModel < SharedKernel::Infrastructure::ApplicationRecord
      self.table_name = "grades"

      belongs_to :student, class_name: "Infrastructure::Models::StudentModel"
      belongs_to :discipline, class_name: "Infrastructure::Models::DisciplineModel"
    
      validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
      
      def self.model_name
        ActiveModel::Name.new(self, nil, "grade")
      end
    end
  end
end
