require "rails_helper"

RSpec.describe Domain::Exceptions::GradeException, type: :exception do
  describe "#initialize" do
    it "raises a GradeException with the correct error message" do
      expect {
        raise Domain::Exceptions::GradeException.new("Grade validation failed")
      }.to raise_error(Domain::Exceptions::GradeException)
    end
  end
end
