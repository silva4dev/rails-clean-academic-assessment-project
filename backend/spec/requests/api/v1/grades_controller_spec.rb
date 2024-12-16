require "swagger_helper"

RSpec.describe "api/v1/grades", type: :request do
  path "/api/v1/grades" do
    post("Create a new grade") do
      tags "Grades"
      consumes "application/json"
      produces "application/json"

      parameter name: :grade, in: :body, schema: {
        type: :object,
        properties: {
          student_id: { 
            type: :string, 
            description: "Student ID" 
          },
          discipline_id: { 
            type: :string, 
            description: "Discipline ID" 
          },
          value: { 
            type: :number, 
            description: "Value (e.g., 0-100)" 
          }
        },
        required: %w[student_id discipline_id value]
      }

      response(201, "created") do
        let(:grade) do
          {
            student_id: "4b7243cf-ff2d-44b0-bf25-150e701dcf26",
            discipline_id: "d3248c8e-a688-4917-9960-d896a25a721e",
            value: 90
          }
        end
        run_test!
      end

      response(422, "unprocessable entity") do
        let(:grade) { { student_id: nil, discipline_id: nil, value: nil } }
        run_test!
      end

      response(404, "not found") do
        run_test!
      end

      response(500, "internal server error") do 
        run_test!
      end
    end
  end
end
