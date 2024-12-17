require "rails_helper"

RSpec.describe Domain::Repositories::StudentRepository, type: :repository do
  let(:repository) { Domain::Repositories::StudentRepository.new }

  describe "#find_by_id" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.find_by_id(1)
      }.to raise_error(NotImplementedError)
    end
  end

  describe "#get_students" do
    it "raises NotImplementedError when called directly" do
      expect {
        repository.get_students
      }.to raise_error(NotImplementedError)
    end
  end
end
