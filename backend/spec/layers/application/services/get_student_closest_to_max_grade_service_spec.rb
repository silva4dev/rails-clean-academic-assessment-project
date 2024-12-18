require 'rails_helper'

RSpec.describe Application::Services::GetStudentClosestToMaxGradeService, type: :service do
  let(:student_repository) { instance_double(Infrastructure::Repositories::StudentRepository) }
  let(:grade_repository) { instance_double(Infrastructure::Repositories::GradeRepository) }

  let(:service) { described_class.new(student: student_repository, grade: grade_repository) }

  describe "#execute" do
    context "when there are students and grades" do
      let(:student1) { Domain::Entities::StudentEntity.new(
        id: "6056d8d0-9f19-013d-6beb-00155d28bfb2",
        name: "John Doe",
        created_at: Time.new,
        updated_at: Time.new
      ) }
      let(:student2) { Domain::Entities::StudentEntity.new(
        id: "69d078f9-5258-468a-8f73-4f3a6baf7ee5",
        name: "Jenny Doe",
        created_at: Time.new,
        updated_at: Time.new
      ) }
      before do
        allow(student_repository).to receive(:get_students).and_return([ student1, student2 ])
        allow(grade_repository).to receive(:get_final_grade_by_student).with(student1.id).and_return(90.5)
        allow(grade_repository).to receive(:get_final_grade_by_student).with(student2.id).and_return(95.0)
      end

      it "returns the student with the highest grade" do
        result = service.execute

        expect(result.success[:data][:id]).to eq(student2.id)
        expect(result.success[:data][:name]).to eq(student2.name)
        expect(result.success[:data][:final_grade]).to eq(95.0)
      end
    end

    context "when there are no students" do
      before do
        allow(student_repository).to receive(:get_students).and_return([])
      end

      it "returns a failure with error message" do
        result = service.execute

        expect(result.failure[:error]).to eq("No students found")
        expect(result.failure[:code]).to eq(404)
      end
    end

    context "when there are students but no grades" do
      let(:student1) { double("Student", id: "1", name: "John Doe") }
      let(:student2) { double("Student", id: "2", name: "Jane Smith") }

      before do
        allow(student_repository).to receive(:get_students).and_return([ student1, student2 ])
        allow(grade_repository).to receive(:get_final_grade_by_student).with(student1.id).and_return(nil)
        allow(grade_repository).to receive(:get_final_grade_by_student).with(student2.id).and_return(nil)
      end

      it "returns a failure with error message" do
        result = service.execute

        expect(result.failure[:error]).to eq("No grades found for students")
        expect(result.failure[:code]).to eq(404)
      end
    end
  end
end
