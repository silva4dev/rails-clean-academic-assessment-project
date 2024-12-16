require_relative "../../../../shared_kernel/application/application_controller"
require_relative "../../../dtos/create_grade_input_dto"
require_relative "../../../services/create_new_grade_service"
require_relative "../../../services/get_student_grades_service"
require_relative "../../../dtos/get_grades_input_dto"

module Application
  module Controllers
    module Api 
      module V1 
        class GradesController < SharedKernel::Application::ApplicationController
          def show
            input_dto = Dtos::GetGradesInputDto.new(student_id: params[:id])
            result = Services::GetStudentGradesService.new.execute(input_dto)
            if result.success?
              
            else 

            end
          end

          def create
            input_dto = Dtos::CreateGradeInputDto.new(
              student_id: params[:student_id],
              discipline_id: params[:discipline_id],
              value: params[:value]
            )
            result = Services::CreateNewGradeService.new.execute(input_dto)
            if result.success? 
              render json: { 
                message: result.success[:message] 
              }, status: result.success[:code]
            else 
              render json: { 
                error: result.failure[:error] 
              }, status: result.failure[:code] 
            end
          end
        end
      end
    end
  end
end
