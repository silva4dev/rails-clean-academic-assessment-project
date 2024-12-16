require "rails_helper"

RSpec.describe Application::Dtos::GetGradesInputDto, type: :dto do
  context "with valid attributes" do
    it "returns a representation of the DTO" do
      input = Application::Dtos::GetGradesInputDto.new(
        student_id: "student-123"
      )
      expect(input.student_id).to eq("student-123")
    end
  end

  context "with invalid attributes" do
    it "raises an error for missing required attributes" do
      expect {
        Application::Dtos::GetGradesInputDto.new
      }.to raise_error(Dry::Struct::Error)
    end

    it "raises an error for invalid types" do
      expect {
        Application::Dtos::GetGradesInputDto.new(
          student_id: 12345
        )
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
