require "rails_helper"

RSpec.describe Domain::Validations::StudentValidation, type: :validation do
  describe "StudentValidation" do
    context "when valid attributes are provided" do
      it "passes validation with a valid name" do
        result = Domain::Validations::StudentValidation.new.call(name: "John Doe")
        expect(result.success?).to be(true)
      end
    end

    context "when invalid attributes are provided" do
      it "fails validation when name is missing" do
        result = Domain::Validations::StudentValidation.new.call(name: nil)
        expect(result.success?).to be(false)
        expect(result.errors[:name]).to include("must be filled")
      end

      it "fails validation when name is empty" do
        result = Domain::Validations::StudentValidation.new.call(name: "")
        expect(result.success?).to be(false)
        expect(result.errors[:name]).to include("must be filled")
      end
    end
  end
end
