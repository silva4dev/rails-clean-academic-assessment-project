require "rails_helper"

RSpec.describe Application::Dtos::CreateGradeInputDto, type: :dto do
  context "with valid attributes" do
    it "returns a representation of the DTO" do
      input = Application::Dtos::CreateGradeInputDto.new(
        student_id: "student-123",
        discipline_id: "discipline-456",
        value: 85.5
      )
      expect(input.student_id).to eq("student-123")
      expect(input.discipline_id).to eq("discipline-456")
      expect(input.value).to eq(85.5)
    end
  end

  context "with invalid attributes" do
    it "raises an error for missing required attributes" do
      expect {
        Application::Dtos::CreateGradeInputDto.new(
          discipline_id: "discipline-456",
          value: 85.5
        )
      }.to raise_error(Dry::Struct::Error)
    end

    it "raises an error for invalid types" do
      expect {
        Application::Dtos::CreateGradeInputDto.new(
          student_id: "student-123",
          discipline_id: "discipline-456",
          value: "invalid"
        )
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
