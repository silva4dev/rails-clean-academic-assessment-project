require "rails_helper"

RSpec.describe Infrastructure::Repositories::GradeRepository, type: :repository do
  let(:repository) { Infrastructure::Repositories::GradeRepository.new }

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

  describe "#get_latest_grades_by_student" do
  it "returns the latest grades for each discipline of a student" do
    student = Infrastructure::Models::StudentModel.create!(name: "Jane Doe")
    discipline1 = Infrastructure::Models::DisciplineModel.create!(name: "Math")
    discipline2 = Infrastructure::Models::DisciplineModel.create!(name: "Science")

    Infrastructure::Models::GradeModel.create!(student_id: student.id, discipline_id: discipline1.id, value: 80.0)
    Infrastructure::Models::GradeModel.create!(student_id: student.id, discipline_id: discipline1.id, value: 75.2)
    Infrastructure::Models::GradeModel.create!(student_id: student.id, discipline_id: discipline2.id, value: 90.0)

    result = repository.get_latest_grades_by_student(student.id)

    expect(result.size).to eq(2)
    expect(result.map { |r| r[:discipline][:name] }).to match_array([ "Math", "Science" ])
  end
end

  describe "#get_final_grade_by_student" do
    it "returns the average grade of a student across all disciplines" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Smith")
      discipline1 = Infrastructure::Models::DisciplineModel.create!(name: "History")
      discipline2 = Infrastructure::Models::DisciplineModel.create!(name: "Geography")

      Infrastructure::Models::GradeModel.create!(student_id: student.id, discipline_id: discipline1.id, value: 80.0)
      Infrastructure::Models::GradeModel.create!(student_id: student.id, discipline_id: discipline2.id, value: 90.0)

      final_grade = repository.get_final_grade_by_student(student.id)

      expect(final_grade).to eq(85.0)
    end
  end
end
