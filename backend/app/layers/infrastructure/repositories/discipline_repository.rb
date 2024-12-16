require_relative "../../domain/repositories/discipline_repository"
require_relative "../models/discipline_model"

module Infrastructure
  module Repositories
    class DisciplineRepository < Domain::Repositories::DisciplineRepository
      def find_by_id(id)
        Models::DisciplineModel.find_by(id: id)
      end
    end
  end
end
