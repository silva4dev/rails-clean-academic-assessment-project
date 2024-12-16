require_relative "../../shared_kernel/infrastructure/mapper"
require_relative "../../domain/entities/history_entity"
require_relative "../../domain/entities/student_entity"

module Infrastructure
  module Mappers 
    class GetTopStudentsMapper < SharedKernel::Infrastructure::Mapper
      def self.to_entity(dao)
        Domain::Entities::HistoryEntity.new(
          id: dao.id,
          final_grade: dao.final_grade.to_f,
          reference_date: dao.reference_date,
          created_at: dao.created_at,
          updated_at: dao.updated_at,
          student: Domain::Entities::StudentEntity.new(
            id: dao.student.id,
            name: dao.student.name,
            created_at: dao.created_at,
            updated_at: dao.updated_at
          )
        )
      end
      
      def self.to_dao(entity)
        {
          id: entity.id,
          final_grade: entity.final_grade,
          reference_date: entity.reference_date,
          created_at: entity.created_at,
          updated_at: entity.updated_at,
          student: {
            id: entity.student.id,
            name: entity.student.name,
            created_at: entity.student.created_at,
            updated_at: entity.student.updated_at
          }
        }
      end
    end
  end
end
