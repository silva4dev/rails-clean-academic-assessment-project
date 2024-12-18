require "swagger_helper"

RSpec.describe "/api/v1/students", type: :request do
  path "/api/v1/students" do
    get("List top students") do
      tags "Students"
      produces "application/json"

      response(200, "successful") do
        let(:id) { "d4c1c04b-d38a-4d97-8197-7df6afe00e5a" }

        before do
          student = Infrastructure::Models::StudentModel.create(id: id, name: "John Doe")
          Infrastructure::Models::HistoryModel.create(
            student_id: student.id,
            final_grade: 90.5,
            reference_date: (Date.today - 1.month).beginning_of_month
          )
        end

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
        run_test!
      end

      response(404, "not found") do
        let(:id) { "non-existent-id" }

        before do
          allow(Infrastructure::Models::StudentModel).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        end

        run_test!
      end
    end
  end

  path "/api/v1/student" do
    get("Get student closest to maximum grade (100)") do
      tags "Students"
      produces "application/json"
      response(200, "successful") do
        let!(:student1) { Infrastructure::Models::StudentModel.create(id: "d4c1c04b-d38a-4d97-8197-7df6afe00e5a", name: "John Doe") }
        let!(:student2) { Infrastructure::Models::StudentModel.create(id: "9702bc7f-5247-402c-be24-01a42b244f0a", name: "Jane Smith") }
        let!(:discipline1) do 
          Infrastructure::Models::DisciplineModel.create(
            id: "2bb57054-b101-4268-b029-cdded0668037",
            name: "Math",
            days_interval: 90
          )
        end
        before do
          Infrastructure::Models::GradeModel.create(student_id: student1.id, discipline_id: discipline1, value: 50.0)
          Infrastructure::Models::GradeModel.create(student_id: student2.id, discipline_id: discipline1, value: 50.0)
        end

        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string, description: "Student ID" },
                     name: { type: :string, description: "Student Name" },
                     final_grade: { type: :number, format: :float, description: "Final grade" }
                   }
                 }
               }
        run_test!
      end

      response(404, "no students found") do
        before do
          allow(Infrastructure::Models::StudentModel).to receive(:all).and_raise(ActiveRecord::RecordNotFound)
        end

        run_test!
      end
    end
  end
end
