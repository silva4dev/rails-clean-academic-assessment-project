require_relative "../../../../shared_kernel/application/application_controller"
require_relative "../../../services/get_top_students_service"
require_relative "../../../dtos/get_top_students_input_dto"

module Application
  module Controllers
    module Api 
      module V1 
        class StudentsController < SharedKernel::Application::ApplicationController
          def index 
            input_dto = Dtos::GetTopStudentsInputDto.new(
              start_date: (Date.today - 1.month).beginning_of_month,
              end_date: (Date.today - 1.month).end_of_month
            )
            result = Services::GetTopStudentsService.new.execute(input_dto)
            if result.success? 
              render json: { data: result.success[:histories] }, status: result.success[:code]
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
