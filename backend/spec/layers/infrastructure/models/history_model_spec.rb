require "rails_helper"

RSpec.describe Infrastructure::Models::HistoryModel, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      history = Infrastructure::Models::HistoryModel.new(
        student: student,
        reference_date: Date.today,
        final_grade: 85.0
      )
      expect(history).to be_valid
    end

    it "is invalid without a reference_date" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      history = Infrastructure::Models::HistoryModel.new(
        student: student,
        reference_date: nil,
        final_grade: 85.0
      )
      expect(history).not_to be_valid
      expect(history.errors[:reference_date]).to include("can't be blank")
    end

    it "is invalid if final_grade is less than 0" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      history = Infrastructure::Models::HistoryModel.new(
        student: student,
        reference_date: Date.today,
        final_grade: -1
      )
      expect(history).not_to be_valid
      expect(history.errors[:final_grade]).to include("must be greater than or equal to 0")
    end

    it "is invalid if final_grade is greater than 100" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      history = Infrastructure::Models::HistoryModel.new(
        student: student,
        reference_date: Date.today,
        final_grade: 101
      )
      expect(history).not_to be_valid
      expect(history.errors[:final_grade]).to include("must be less than or equal to 100")
    end
  end

  describe "associations" do
    it "belongs to a student" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      history = Infrastructure::Models::HistoryModel.create!(
        student: student,
        reference_date: Date.today,
        final_grade: 85.0
      )
      expect(history.student).to eq(student)
    end
  end

  describe ".model_name" do
    it "returns 'history' as the model name" do
      expect(Infrastructure::Models::HistoryModel.model_name.name).to eq("history")
    end
  end
end
