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
            student_id: "99a2adcf-a03b-43a6-9d18-0b6e3a0eb822",
            discipline_id: "2bb57054-b101-4268-b029-cdded0668037",
            value: 90.50
          }
        end

        before do
          student = Infrastructure::Models::StudentModel.create(id: "99a2adcf-a03b-43a6-9d18-0b6e3a0eb822", name: "John Doe")
          discipline =  Infrastructure::Models::DisciplineModel.create(
            id: "2bb57054-b101-4268-b029-cdded0668037",
            name: "Math",
            days_interval: 90
          )
          Infrastructure::Models::GradeModel.create(
            student_id: student.id,
            discipline_id: discipline.id,
            value: 90.50
          )
        end

        run_test!
      end

      response(404, "not found") do
        let(:grade) do
          {
            student_id: "99a2adcf-a03b-43a6-9d18-0b6e3a0eb822",
            discipline_id: "2bb57054-b101-4268-b029-cdded0668037",
            value: 90.50
          }
        end

        before do
          allow(Infrastructure::Models::StudentModel).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        end

        run_test!
      end
    end
  end

  path "/api/v1/grades/students/{id}" do
    get("Get grades and final grade for a student") do
      tags "Grades"
      produces "application/json"
      parameter name: :id, in: :path, type: :string, description: "Student ID"

      response(200, "successful") do
        let(:id) { "99a2adcf-a03b-43a6-9d18-0b6e3a0eb822" }
      
        before do
          student = Infrastructure::Models::StudentModel.create(id: id, name: "John Doe")
          discipline = Infrastructure::Models::DisciplineModel.create(id: "2bb57054-b101-4268-b029-cdded0668037", name: "Math")
          Infrastructure::Models::GradeModel.create(student_id: student.id, discipline_id: discipline.id, value: 90.0) # Ensure value is a number
        end
      
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: {
              id: { type: :string },
              name: { type: :string },
              grades: { type: :array, items: { type: :object } },
              final_grade: { type: :number } 
            }
          }
        }
      
        run_test!
      end

      response(404, "not found") do
        let(:id) { "non-existent-id" }

        before do
          allow(Infrastructure::Models::DisciplineModel).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        end

        run_test!
      end
    end
  end
end
