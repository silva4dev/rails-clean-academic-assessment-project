require "rails_helper"

RSpec.describe Domain::Exceptions::HistoryException, type: :exception do
  describe "#initialize" do
    it "raises a HistoryException with the correct error message" do
      expect {
        raise Domain::Exceptions::HistoryException.new("History validation failed")
      }.to raise_error(Domain::Exceptions::HistoryException)
    end
  end
end
