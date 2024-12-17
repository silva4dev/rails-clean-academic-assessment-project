require "rails_helper"

RSpec.describe Application::Services::GetStudentGradesService, type: :service do
  let(:student_repository) { instance_double(Infrastructure::Repositories::StudentRepository) }
  let(:grade_repository) { instance_double(Infrastructure::Repositories::GradeRepository) }
  let(:service) { described_class.new(student: student_repository, grade: grade_repository) }
  let(:input_dto) { double("GetGradesInputDto", student_id: 1) }

  describe "#execute" do
    context "when student is found" do
      let!(:student) { Domain::Entities::StudentEntity.new(
        name: "John Doe",
        created_at: Time.new,
        updated_at: Time.new
      ) }
      let!(:discipline) { Domain::Entities::DisciplineEntity.new(
        name: "Math",
        days_interval: 90,
        created_at: Time.new,
        updated_at: Time.new
      ) }
      let(:grades) { [ Domain::Entities::GradeEntity.new(
        student_id: student.id.value,
        discipline_id: discipline.id.value,
        value: 50.0,
        created_at: Time.new,
        updated_at: Time.new
      ) ] }
      let(:final_grade) { 50.0 }
      before do
        allow(student_repository).to receive(:find_by_id).with(1).and_return(student)
        allow(grade_repository).to receive(:get_latest_grades_by_student).with(1).and_return(grades)
        allow(grade_repository).to receive(:get_final_grade_by_student).with(1).and_return(final_grade)
      end

      it "returns a successful response with student grades and final grade" do
        result = service.execute(input_dto)
   
        expect(result.success[:data][:name]).to eq(student.name)
        expect(result.success[:data][:final_grade]).to eq(50.0)
      end
    end
  end
end
