require "rails_helper"

RSpec.describe Domain::Validations::GradeValidation, type: :validation do
  describe "GradeValidation" do
    context "when valid attributes are provided" do
      it "passes validation with valid student_id, discipline_id, and value" do
        result = Domain::Validations::GradeValidation.new.call(
          student_id: "student-123",
          discipline_id: "discipline-456",
          value: 85.0
        )
        expect(result.success?).to be(true)
      end
    end

    context "when invalid attributes are provided" do
      it "fails validation when student_id is missing" do
        result = Domain::Validations::GradeValidation.new.call(
          student_id: "",
          discipline_id: "discipline-456",
          value: 85.0
        )
        expect(result.success?).to be(false)
        expect(result.errors[:student_id]).to include("must be filled")
      end

      it "fails validation when discipline_id is missing" do
        result = Domain::Validations::GradeValidation.new.call(
          student_id: "student-123",
          discipline_id: "",
          value: 85.0
        )
        expect(result.success?).to be(false)
        expect(result.errors[:discipline_id]).to include("must be filled")
      end

      it "fails validation when value is missing" do
        result = Domain::Validations::GradeValidation.new.call(
          student_id: "student-123",
          discipline_id: "discipline-456",
          value: nil
        )
        expect(result.success?).to be(false)
        expect(result.errors[:value]).to include("must be filled")
      end

      it "fails validation when value is less than 0" do
        result = Domain::Validations::GradeValidation.new.call(
          student_id: "student-123",
          discipline_id: "discipline-456",
          value: -5.0
        )
        expect(result.success?).to be(false)
        expect(result.errors[:value]).to include("must be greater than or equal to 0")
      end

      it "fails validation when value is greater than 100" do
        result = Domain::Validations::GradeValidation.new.call(
          student_id: "student-123",
          discipline_id: "discipline-456",
          value: 105.0
        )
        expect(result.success?).to be(false)
        expect(result.errors[:value]).to include("must be less than or equal to 100")
      end
    end
  end
end
