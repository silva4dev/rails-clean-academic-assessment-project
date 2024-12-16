require "rails_helper"

RSpec.describe Infrastructure::Repositories::HistoryRepository, type: :repository do
  describe "#get_histories_by_student" do
    it "returns histories for a given student" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      Infrastructure::Models::HistoryModel.create!(
        student: student, 
        reference_date: Date.new(2024, 5, 1), 
        final_grade: 90
      )
      Infrastructure::Models::HistoryModel.create!(
        student: student, 
        reference_date: Date.new(2024, 5, 10), 
        final_grade: 85
      )
      repo = Infrastructure::Repositories::HistoryRepository.new
      histories = repo.get_histories_by_student(student.id)
      expect(histories.count).to eq(2)
      expect(histories.first.final_grade).to eq(90)
      expect(histories.second.final_grade).to eq(85)
    end
  end

  describe "#get_histories_by_reference_date" do
    it "returns histories within a given date range ordered by final grade" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      Infrastructure::Models::HistoryModel.create!(
        student: student, 
        reference_date: Date.new(2024, 5, 1), 
        final_grade: 80
      )
      Infrastructure::Models::HistoryModel.create!(
        student: student, 
        reference_date: Date.new(2024, 5, 10), 
        final_grade: 90
      )
      Infrastructure::Models::HistoryModel.create!(
        student: student, 
        reference_date: Date.new(2024, 5, 15), 
        final_grade: 85
      )
      repo = Infrastructure::Repositories::HistoryRepository.new
      histories = repo.get_histories_by_reference_date(Date.new(2024, 5, 1), Date.new(2024, 5, 15))
      expect(histories.count).to eq(3)
      expect(histories.first.final_grade).to eq(90)
      expect(histories.second.final_grade).to eq(85)
      expect(histories.third.final_grade).to eq(80)
    end
  end
end
