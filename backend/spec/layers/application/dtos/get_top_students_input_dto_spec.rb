require "rails_helper"

RSpec.describe Application::Dtos::GetTopStudentsInputDto, type: :dto do
  context "with valid attributes" do
    it "returns a representation of the DTO" do
      input = Application::Dtos::GetTopStudentsInputDto.new(
        start_date: Date.new(2024, 1, 1),
        end_date: Date.new(2024, 12, 31)
      )
      expect(input.start_date).to eq(Date.new(2024, 1, 1))
      expect(input.end_date).to eq(Date.new(2024, 12, 31))
    end
  end

  context "with invalid attributes" do
    it "raises an error for missing required attributes" do
      expect {
        Application::Dtos::GetTopStudentsInputDto.new
      }.to raise_error(Dry::Struct::Error)
    end

    it "raises an error for invalid types for :start_date and :end_date" do
      expect {
        Application::Dtos::GetTopStudentsInputDto.new(
          start_date: "invalid-date",
          end_date: 12345
        )
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
