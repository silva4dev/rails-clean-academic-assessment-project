require "rails_helper"

RSpec.describe Domain::Validations::DisciplineValidation, type: :validation do
  describe "DisciplineValidation" do
    context "when valid attributes are provided" do
      it "passes validation with a valid name" do
        result = Domain::Validations::DisciplineValidation.new.call(name: "Mathematics", days_interval: 100)
        expect(result.success?).to be(true)
      end

      it "passes validation when days_interval is within range" do
        result = Domain::Validations::DisciplineValidation.new.call(name: "Mathematics", days_interval: 180)
        expect(result.success?).to be(true)
      end
    end

    context "when invalid attributes are provided" do
      it "fails validation when name is missing" do
        result = Domain::Validations::DisciplineValidation.new.call(name: "", days_interval: 100)
        expect(result.success?).to be(false)
        expect(result.errors[:name]).to include("must be filled")
      end

      it "fails validation when days_interval is less than 90" do
        result = Domain::Validations::DisciplineValidation.new.call(name: "Mathematics", days_interval: 50)
        expect(result.success?).to be(false)
        expect(result.errors[:days_interval]).to include("must be greater than or equal to 90")
      end

      it "fails validation when days_interval is greater than 365" do
        result = Domain::Validations::DisciplineValidation.new.call(name: "Mathematics", days_interval: 400)
        expect(result.success?).to be(false)
        expect(result.errors[:days_interval]).to include("must be less than or equal to 365")
      end
    end
  end
end
