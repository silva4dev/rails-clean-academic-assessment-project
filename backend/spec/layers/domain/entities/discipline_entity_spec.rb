require "rails_helper"

RSpec.describe Domain::Entities::DisciplineEntity, type: :entity do
  describe "#initialize" do
    context "when attributes are valid" do
      it "creates a DisciplineEntity instance with valid attributes" do
        discipline = Domain::Entities::DisciplineEntity.new(
          name: "Discipline 1",
          days_interval: 90,
          created_at: Time.new,
          updated_at: Time.new
        )
        
        expect(discipline.name).to eq("Discipline 1")
        expect(discipline.days_interval).to eq(90)
      end
    end

    context "when attributes are invalid" do
      it "raises a DisciplineException for invalid attributes" do
        expect {
          Domain::Entities::DisciplineEntity.new(
            name: "Discipline 1",
            days_interval: 90
          )
        }.to raise_error(StandardError)
      end
    end
  end
end
