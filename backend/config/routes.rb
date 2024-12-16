Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # namespace :v1 do
  #   post "/grades", to: "grades#create"
  #   get "/grades/students/:id", to: "grades#show"
  #   get "/histories/students/:id", to: "histories#show"
  #   get "/students", to: "students#index"
  # end

  scope module: :application do
    scope module: :controllers do
      namespace :api do 
        namespace :v1 do
          post "grades", to: "grades#create"
          get "grades/students/:id", to: "grades#show"
          get "histories/students/:id", to: "histories#show"
          get "students", to: "students#index"
        end
      end
    end
  end
end