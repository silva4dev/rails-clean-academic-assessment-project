require_relative "../../shared_kernel/infrastructure/mapper"
require_relative "../../domain/entities/history_entity"
require_relative "../../domain/entities/student_entity"

module Infrastructure
  module Mappers 
    class GetStudentGradesMapper < SharedKernel::Infrastructure::Mapper
      def self.to_dao(entity)
        {
          id: entity.id,
          value: entity.value,
          created_at: entity.created_at,
          updated_at: entity.updated_at,
          discipline: {
            id: entity.discipline.id,
            name: entity.discipline.name,
            days_interval: entity.discipline.days_interval,
            created_at: entity.discipline.created_at,
            updated_at: entity.discipline.updated_at
          }
        }       
      end
    end
  end
end
