require "rails_helper"

RSpec.describe Domain::Entities::StudentEntity, type: :model do
  describe "#initialize" do
    context "when attributes are valid" do
      it "creates a StudentEntity instance with valid attributes" do
        student = Domain::Entities::StudentEntity.new(
          name: "John Doe",
          created_at: Time.new,
          updated_at: Time.new
        )
        expect(student.name).to eq("John Doe")
      end
    end

    context "when attributes are invalid" do
      it "raises a StudentException for invalid attributes" do
        expect {
          Domain::Entities::StudentEntity.new(
            name: ""
          )
        }.to raise_error(StandardError)
      end
    end
  end
end
