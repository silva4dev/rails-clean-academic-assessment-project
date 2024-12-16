require "swagger_helper"

RSpec.describe "api/v1/histories/students/:id", type: :request do
  path "/api/v1/histories/students/{id}" do
    parameter name: "id", in: :path, type: :string, description: "Student ID"
    get("Get histories for a student") do
      tags "Histories"
      produces "application/json"
      response(200, "successful") do
        let(:id) { "2fa1a9d5-7549-4bb9-a304-849bdcbaca15" }
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string, description: "History ID" },
                       final_grade: { type: :number, format: :float, description: "Final grade" },
                       reference_date: { type: :string, format: :date, description: "Reference date" },
                       created_at: { type: :string, format: :date_time, description: "Created_at" },
                       updated_at: { type: :string, format: :date_time, description: "Updated_at" },
                       student: {
                         type: :object,
                         properties: {
                           id: { type: :string, description: "Student ID" },
                           name: { type: :string, description: "Name" },
                           created_at: { type: :string, format: :date_time, description: "Created_at" },
                           updated_at: { type: :string, format: :date_time, description: "Updated_at" }
                         }
                       }
                     }
                   }
                 }
               }
      end
      response(404, "not found") do
      end
      response(500, "internal server error") do 
      end
    end
  end
end
