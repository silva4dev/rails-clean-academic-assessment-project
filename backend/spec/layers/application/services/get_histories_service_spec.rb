require "rails_helper"

RSpec.describe Application::Services::GetHistoriesService, type: :service do
  let(:student_repository) { instance_double("Infrastructure::Repositories::StudentRepository") }
  let(:history_repository) { instance_double("Infrastructure::Repositories::HistoryRepository") }
  let(:service) { described_class.new(student: student_repository, history: history_repository) }
  let(:student_id) { "1" }
  let(:input_dto) { double("GetHistoriesInputDto", student_id: student_id) }

  describe "#execute" do
    context "when the student is not found" do
      before do
        allow(student_repository).to receive(:find_by_id).with(student_id).and_return(nil)
      end

      it "returns a failure response with an error message and a 404 code" do
        result = service.execute(input_dto)
        expect(result.failure[:error]).to eq("Student with id #{student_id} not found")
        expect(result.failure[:code]).to eq(404)
      end
    end

    context "when the student is found" do
      let(:student) { double("Student") }
      let(:histories) do
        [
          double("History", to_h: { id: 1, grade: "A" }),
          double("History", to_h: { id: 2, grade: "B" })
        ]
      end

      before do
        allow(student_repository).to receive(:find_by_id).with(student_id).and_return(student)
        allow(history_repository).to receive(:get_histories_by_student).with(student_id).and_return(histories)
      end

      it "returns a success response with histories and a 200 code" do
        result = service.execute(input_dto)
        expect(result).to be_success
        expect(result.success[:histories]).to eq(histories.map(&:to_h))
        expect(result.success[:code]).to eq(200)
      end
    end
  end
end
