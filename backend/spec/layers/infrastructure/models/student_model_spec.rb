require "rails_helper"

RSpec.describe Infrastructure::Models::StudentModel, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      student = Infrastructure::Models::StudentModel.new(name: "John Doe")
      expect(student).to be_valid
    end

    it "is invalid without a name" do
      student = Infrastructure::Models::StudentModel.new(name: nil)
      expect(student).not_to be_valid
      expect(student.errors[:name]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "has many grades" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math")
      grade = Infrastructure::Models::GradeModel.create!(
        student: student, 
        discipline: discipline, 
        value: 90.0
      )
      expect(student.grades).to include(grade)
    end

    it "has many histories" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      history = Infrastructure::Models::HistoryModel.create!(
        student: student, 
        reference_date: Date.today, 
        final_grade: 85.0
      )
      expect(student.histories).to include(history)
    end

    it "has many disciplines through grades" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math")
      Infrastructure::Models::GradeModel.create!(student: student, discipline: discipline, value: 90.0)
      expect(student.disciplines).to include(discipline)
    end
  end

  describe ".model_name" do
    it "returns 'student' as the model name" do
      expect(Infrastructure::Models::StudentModel.model_name.name).to eq("student")
    end
  end
end
