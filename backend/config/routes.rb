Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  scope module: :application do
    scope module: :controllers do
      namespace :api do 
        namespace :v1 do
          post "grades", to: "grades#create" # FEITO
          get "grades/students/:id", to: "grades#show" 
          get "histories/students/:id", to: "histories#show" # FEITO
          get "students", to: "students#index" # FEITO
        end
      end
    end
  end
end
