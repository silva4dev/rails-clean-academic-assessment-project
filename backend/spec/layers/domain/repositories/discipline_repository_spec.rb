require "rails_helper"

RSpec.describe Domain::Repositories::DisciplineRepository, type: :repository do
  describe "#find_by_id" do
    it "raises NotImplementedError when called directly" do
      repository = Domain::Repositories::DisciplineRepository.new

      expect {
        repository.find_by_id(1)
      }.to raise_error(NotImplementedError)
    end
  end
end
