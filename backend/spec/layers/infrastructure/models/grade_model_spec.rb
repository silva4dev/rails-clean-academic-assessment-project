require "rails_helper"

RSpec.describe Infrastructure::Models::GradeModel, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      student = Infrastructure::Models::StudentModel.create!(name: "Test Student")
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math")
      grade = Infrastructure::Models::GradeModel.new(
        student: student,
        discipline: discipline,
        value: 85.0
      )
      expect(grade).to be_valid
    end

    it "is invalid if the value is less than 0" do
      student = Infrastructure::Models::StudentModel.create!(name: "Test Student")
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math")
      grade = Infrastructure::Models::GradeModel.new(
        student: student,
        discipline: discipline,
        value: -5.0
      )
      expect(grade).not_to be_valid
      expect(grade.errors[:value]).to include("must be greater than or equal to 0")
    end

    it "is invalid if the value is greater than 100" do
      student = Infrastructure::Models::StudentModel.create!(name: "Test Student")
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math")
      grade = Infrastructure::Models::GradeModel.new(
        student: student,
        discipline: discipline,
        value: 105.0
      )
      expect(grade).not_to be_valid
      expect(grade.errors[:value]).to include("must be less than or equal to 100")
    end

    it "is invalid without a student" do
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math")
      grade = Infrastructure::Models::GradeModel.new(
        discipline: discipline,
        value: 85.0
      )
      expect(grade).not_to be_valid
      expect(grade.errors[:student]).to include("must exist")
    end

    it "is invalid without a discipline" do
      student = Infrastructure::Models::StudentModel.create!(name: "Test Student")
      grade = Infrastructure::Models::GradeModel.new(
        student: student,
        value: 85.0
      )
      expect(grade).not_to be_valid
      expect(grade.errors[:discipline]).to include("must exist")
    end
  end
end
