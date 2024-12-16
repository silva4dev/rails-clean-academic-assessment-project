require_relative "../../domain/repositories/student_repository"
require_relative "../models/student_model"

module Infrastructure
  module Repositories
    class StudentRepository < Domain::Repositories::StudentRepository
      def find_by_id(id)
        Models::StudentModel.find_by(id: id)
      end
    end
  end
end
