require_relative "../../../../shared_kernel/application/application_controller"
require_relative "../../../dtos/get_histories_input_dto"
require_relative "../../../services/get_histories_service"

module Application
  module Controllers
    module Api 
      module V1 
        class HistoriesController < SharedKernel::Application::ApplicationController
          def show
            input_dto = Dtos::GetHistoriesInputDto.new(student_id: params[:id])
            result = Services::GetHistoriesService.new.execute(input_dto)
            if result.success? 
              render json: { 
                data: result.success[:histories] 
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
