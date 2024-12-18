require "rails_helper"

RSpec.describe Application::Services::MonthlyClosureService, type: :service do
  let(:student_repository) { instance_double(Infrastructure::Repositories::StudentRepository) }
  let(:grade_repository) { instance_double(Infrastructure::Repositories::GradeRepository) }
  let(:history_repository) { instance_double(Infrastructure::Repositories::HistoryRepository) }
  let(:service) { described_class.new(student: student_repository, grade: grade_repository, history: history_repository) }

  describe "#execute" do
    context "when there are students" do
      let(:students) { [
        Domain::Entities::StudentEntity.new(
          id: "6056d8d0-9f19-013d-6beb-00155d28bfb2",
          name: "John Doe",
          created_at: Time.new,
          updated_at: Time.new
        )
      ] }
      let(:final_grade) { 90.0 }

      before do
        allow(student_repository).to receive(:get_students).and_return(students)
        allow(grade_repository).to receive(:get_final_grade_by_student).and_return(final_grade)
        allow(history_repository).to receive(:create)
      end

      it "successfully creates histories for students" do
        result = service.execute

        expect(result.success[:histories].size).to eq(1)
      end
    end

    context "when there are no students" do
      before do
        allow(student_repository).to receive(:get_students).and_return([])
      end

      it "returns failure with an error message" do
        result = service.execute

        expect(result.failure[:error]).to eq("No students found")
        expect(result.failure[:code]).to eq(404)
      end
    end
  end
end
