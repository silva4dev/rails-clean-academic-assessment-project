require "rails_helper"

RSpec.describe Domain::Repositories::HistoryRepository, type: :repository do
  let(:repository) { Domain::Repositories::HistoryRepository.new }

  describe "#get_histories_by_student" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.get_histories_by_student("student-123")
      }.to raise_error(NotImplementedError)
    end
  end

  describe "#get_histories_by_reference_date" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.get_histories_by_reference_date(Date.new(2024, 1, 1), Date.new(2024, 12, 31))
      }.to raise_error(NotImplementedError)
    end
  end
end
