require "rails_helper"

RSpec.describe Application::Services::GetTopStudentsService, type: :service do
  let(:history_repository) { instance_double("Infrastructure::Repositories::HistoryRepository") }
  let(:student_repository) { instance_double("Infrastructure::Repositories::StudentRepository") }
  let(:service) { described_class.new(history: history_repository, student: student_repository) }
  let(:input_dto) { double("GetTopStudentsInputDto", start_date: "2024-11-01", end_date: "2024-11-30") }

  describe "#execute" do
    context "when no histories are found for the given date range" do
      before do
        allow(history_repository).to receive(:get_histories_by_reference_date)
          .with(input_dto.start_date, input_dto.end_date)
          .and_return([])
      end

      it "returns a failure with an error message and a 404 status code" do
        result = service.execute(input_dto)
        expect(result.failure[:error]).to eq("No histories found for the last month")
        expect(result.failure[:code]).to eq(404)
      end
    end

    context "when histories are found for the given date range" do
      let(:histories) do
        [
          double("History", to_h: { id: 1, student_name: "John Doe", grade: "A" }),
          double("History", to_h: { id: 2, student_name: "Jane Smith", grade: "B" })
        ]
      end

      before do
        allow(history_repository).to receive(:get_histories_by_reference_date)
          .with(input_dto.start_date, input_dto.end_date)
          .and_return(histories)
      end

      it "returns a success with the mapped histories and a 200 status code" do
        result = service.execute(input_dto)
        expect(result.success[:histories]).to eq(histories.map(&:to_h))
        expect(result.success[:code]).to eq(200)
      end
    end
  end
end
