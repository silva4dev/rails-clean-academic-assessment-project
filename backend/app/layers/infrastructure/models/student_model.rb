require_relative "../../shared_kernel/infrastructure/application_record"

module Infrastructure
  module Models
    class StudentModel < SharedKernel::Infrastructure::ApplicationRecord
      self.table_name = "students"

      has_many :grades, class_name: "Infrastructure::Models::GradeModel"
      has_many :histories, class_name: "Infrastructure::Models::HistoryModel"
      has_many :disciplines, through: :grades, class_name: "Infrastructure::Models::DisciplineModel"
    
      validates :name, presence: true

      def self.model_name
        ActiveModel::Name.new(self, nil, "student")
      end
    end
  end
end
