require "rails_helper"

RSpec.describe Domain::Entities::GradeEntity, type: :entity do
  describe "#initialize" do
    context "when attributes are valid" do
      it "creates a GradeEntity instance with valid attributes" do
        grade = Domain::Entities::GradeEntity.new(
          student_id: "student-123",
          discipline_id: "discipline-456",
          value: 9.5,
          created_at: Time.new,
          updated_at: Time.new
        )
        expect(grade.student_id).to eq("student-123")
        expect(grade.discipline_id).to eq("discipline-456")
        expect(grade.value).to eq(9.5)
      end
    end

    context "when attributes are invalid" do
      it "raises a GradeException for invalid attributes" do
        expect {
          Domain::Entities::GradeEntity.new(
            student_id: "student-123",
            discipline_id: "discipline-456",
            value: nil
          )
        }.to raise_error(StandardError)
      end
    end
  end
end
