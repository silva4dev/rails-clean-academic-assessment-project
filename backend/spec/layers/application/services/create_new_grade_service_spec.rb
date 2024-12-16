require "rails_helper"

RSpec.describe Application::Services::CreateNewGradeService, type: :service do
  let(:student_repository) { instance_double(Infrastructure::Repositories::StudentRepository) }
  let(:grade_repository) { instance_double(Infrastructure::Repositories::GradeRepository) }
  let(:discipline_repository) { instance_double(Infrastructure::Repositories::DisciplineRepository) }
  let(:student) { Domain::Entities::StudentEntity.new(
    id: "1",
    name: "John Doe",
    created_at: Time.new,
    updated_at: Time.new
  )}
  let(:discipline) { Domain::Entities::DisciplineEntity.new(
    id: "1",
    name: "Discipline 1",
    days_interval: 90,
    created_at: Time.new,
    updated_at: Time.new
  )}
  let(:input_dto) { double("CreateGradeInputDto", student_id: "1", discipline_id: "1", value: 10.0) }
  let(:service) { described_class.new(student: student_repository, grade: grade_repository, discipline: discipline_repository) }
  
  describe "#execute" do
    context "when the student does not exist" do
      before do
        allow(student_repository).to receive(:find_by_id).with("1").and_return(nil)
      end

      it "returns a failure with an error message" do
        result = service.execute(input_dto)

        expect(result.failure[:error]).to eq("Student with id 1 not found")
        expect(result.failure[:code]).to eq(404)
      end
    end

    context "when the discipline does not exist" do
      before do
        allow(student_repository).to receive(:find_by_id).with("1").and_return(student)
        allow(discipline_repository).to receive(:find_by_id).with("1").and_return(nil)
      end

      it "returns a failure with an error message" do
        result = service.execute(input_dto)

        expect(result.failure[:error]).to eq("Discipline with id 1 not found")
        expect(result.failure[:code]).to eq(404)
      end
    end

    context "when grade creation is successful" do
      before do
        allow(student_repository).to receive(:find_by_id).with("1").and_return(student)
        allow(discipline_repository).to receive(:find_by_id).with("1").and_return(discipline)
        allow(grade_repository).to receive(:create).and_return(true)
        allow(student).to receive(:id).and_return("1")
      end

      it "returns a success message" do
        result = service.execute(input_dto)

        expect(result.success[:message]).to eq("Grade successfully created!")
        expect(result.success[:code]).to eq(201)
      end
    end

    context "when grade creation fails" do
      before do
        allow(student_repository).to receive(:find_by_id).with("1").and_return(student)
        allow(discipline_repository).to receive(:find_by_id).with("1").and_return(discipline)
        allow(grade_repository).to receive(:create).and_return(false)
        allow(student).to receive(:id).and_return("1")
      end

      it "returns a failure with an error message" do
        result = service.execute(input_dto)

        expect(result.failure[:error]).to eq("Failed to create grade!")
        expect(result.failure[:code]).to eq(500)
      end
    end
  end
end
