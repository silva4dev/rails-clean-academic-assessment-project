require "rails_helper"

RSpec.describe Domain::Entities::HistoryEntity, type: :entity do
  describe "#initialize" do
    context "when attributes are valid" do
      it "creates a HistoryEntity instance with valid attributes" do
        history = Domain::Entities::HistoryEntity.new(
          reference_date: Date.new(2023, 12, 1),
          final_grade: 9.0,
          created_at: Time.new,
          updated_at: Time.new,
          student: Domain::Entities::StudentEntity.new(
            id: "student-123",
            name: "John Doe",
            created_at: Time.new,
            updated_at: Time.new
          )
        )
        expect(history.reference_date).to eq(Date.new(2023, 12, 1))
        expect(history.final_grade).to eq(9.0)
      end
    end

    context "when attributes are invalid" do
      it "raises a HistoryException for invalid attributes" do
        expect {
          Domain::Entities::HistoryEntity.new(
            reference_date: Date.new(2023, 12, 1),
            final_grade: nil, 
            student: valid_student
          )
        }.to raise_error(StandardError)
      end
    end
  end
end
