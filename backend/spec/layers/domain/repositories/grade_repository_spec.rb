require "rails_helper"

RSpec.describe Domain::Repositories::GradeRepository, type: :repository do
  let(:repository) { Domain::Repositories::GradeRepository.new }

  describe "#create" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.create({ student_id: "student-123", value: 95.0, discipline_id: "discipline-456" })
      }.to raise_error(NotImplementedError)
    end
  end

  describe "#find_by_student_id_with_disciplines" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.find_by_student_id_with_disciplines("student-123")
      }.to raise_error(NotImplementedError)
    end
  end
end
