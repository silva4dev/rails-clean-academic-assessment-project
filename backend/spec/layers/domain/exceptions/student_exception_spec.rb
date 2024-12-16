require "rails_helper"

RSpec.describe Domain::Exceptions::StudentException, type: :exception do
  describe "#initialize" do
    it "raises a StudentException with the correct error message" do
      expect {
        raise Domain::Exceptions::StudentException.new("Student validation failed")
      }.to raise_error(Domain::Exceptions::StudentException)
    end
  end
end
