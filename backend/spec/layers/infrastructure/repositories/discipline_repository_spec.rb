require "rails_helper"

RSpec.describe Infrastructure::Repositories::DisciplineRepository, type: :repository do
  describe "#find_by_id" do
    it "returns a discipline model by id" do
      discipline = Infrastructure::Models::DisciplineModel.create!(name: "Math", days_interval: 180)
      repo = Infrastructure::Repositories::DisciplineRepository.new
      found_discipline = repo.find_by_id(discipline.id)
      expect(found_discipline).to eq(discipline)
    end

    it "returns nil when no discipline is found by id" do
      repo = Infrastructure::Repositories::DisciplineRepository.new
      found_discipline = repo.find_by_id(999)
      expect(found_discipline).to be_nil
    end
  end
end
