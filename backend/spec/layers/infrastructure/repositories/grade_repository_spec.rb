require "rails_helper"

RSpec.describe Infrastructure::Repositories::GradeRepository, type: :repository do
  describe "#create" do
    it "creates a grade and saves it" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math", days_interval: 180)
      grade_input = Application::Dtos::CreateGradeInputDto.new(
        student_id: student.id,
        discipline_id: discipline.id,
        value: 85.5
      )
      repo = Infrastructure::Repositories::GradeRepository.new
      repo.create(grade_input)
      expect(grade_input.student_id).to eq(student.id)
      expect(grade_input.discipline_id).to eq(discipline.id)
      expect(grade_input.value).to eq(85.5)
    end
  end

  describe "#find_by_student_id_with_disciplines" do
    it "returns grades with associated disciplines for a given student" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      discipline1 = Infrastructure::Models::DisciplineModel.create!(name: "Math", days_interval: 180)
      discipline2 = Infrastructure::Models::DisciplineModel.create!(name: "Science", days_interval: 180)
      Infrastructure::Models::GradeModel.create!(student: student, discipline: discipline1, value: 90)
      Infrastructure::Models::GradeModel.create!(student: student, discipline: discipline2, value: 85)
      repo = Infrastructure::Repositories::GradeRepository.new
      grades = repo.find_by_student_id_with_disciplines(student.id).to_a
      expect(grades.count).to eq(2)
      expect(grades.first.discipline.name).to eq("Math")
      expect(grades.second.discipline.name).to eq("Science")
    end

    it "returns an empty array if no grades are found for the student" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      repo = Infrastructure::Repositories::GradeRepository.new
      grades = repo.find_by_student_id_with_disciplines(student.id).to_a
      expect(grades).to be_empty
    end
  end
end
