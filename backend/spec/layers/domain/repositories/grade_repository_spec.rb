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

  describe "#get_latest_grades_by_student" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.get_latest_grades_by_student("student-123")
      }.to raise_error(NotImplementedError)
    end
  end

  describe "#get_final_grade_by_student" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.get_final_grade_by_student("student-123")
      }.to raise_error(NotImplementedError)
    end
  end
end
