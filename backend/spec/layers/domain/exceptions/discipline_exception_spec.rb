require "rails_helper"

RSpec.describe Domain::Exceptions::DisciplineException, type: :exception do
  describe "#initialize" do
    it "raises a DisciplineException with the correct error message" do
      expect {
        raise Domain::Exceptions::DisciplineException.new("Discipline validation failed")
      }.to raise_error(Domain::Exceptions::DisciplineException)
    end
  end
end
