require "rails_helper"

RSpec.describe Domain::Validations::HistoryValidation, type: :validation do
  describe "HistoryValidation" do
    context "when valid attributes are provided" do
      it "passes validation with valid reference_date, final_grade, and student" do
        result = Domain::Validations::HistoryValidation.new.call(
          reference_date: Date.new(2024, 12, 15),
          final_grade: 85.0,
          student: "student-123"
        )
        expect(result.success?).to be(true)
      end
    end

    context "when invalid attributes are provided" do
      it "fails validation when reference_date is missing" do
        result = Domain::Validations::HistoryValidation.new.call(
          reference_date: nil,
          final_grade: 85.0,
          student: "student-123"
        )
        expect(result.success?).to be(false)
        expect(result.errors[:reference_date]).to include("must be filled")
      end

      it "fails validation when final_grade is missing" do
        result = Domain::Validations::HistoryValidation.new.call(
          reference_date: Date.new(2024, 12, 15),
          final_grade: nil,
          student: "student-123"
        )
        expect(result.success?).to be(false)
        expect(result.errors[:final_grade]).to include("must be filled")
      end

      it "fails validation when student is missing" do
        result = Domain::Validations::HistoryValidation.new.call(
          reference_date: Date.new(2024, 12, 15),
          final_grade: 85.0,
          student: nil
        )
        expect(result.success?).to be(false)
        expect(result.errors[:student]).to include("must be filled")
      end

      it "fails validation when final_grade is less than 0" do
        result = Domain::Validations::HistoryValidation.new.call(
          reference_date: Date.new(2024, 12, 15),
          final_grade: -5.0,
          student: "student-123"
        )
        expect(result.success?).to be(false)
        expect(result.errors[:final_grade]).to include("must be greater than or equal to 0")
      end

      it "fails validation when final_grade is greater than 100" do
        result = Domain::Validations::HistoryValidation.new.call(
          reference_date: Date.new(2024, 12, 15),
          final_grade: 105.0,
          student: "student-123"
        )
        expect(result.success?).to be(false)
        expect(result.errors[:final_grade]).to include("must be less than or equal to 100")
      end
    end
  end
end
