require "rails_helper"

RSpec.describe Infrastructure::Repositories::StudentRepository, type: :repository do
  describe "#find_by_id" do
    it "returns the student for a given id" do
      student = Infrastructure::Models::StudentModel.create!(name: "John Doe")
      repo = Infrastructure::Repositories::StudentRepository.new
      found_student = repo.find_by_id(student.id)
      expect(found_student).to eq(student)
      expect(found_student.name).to eq("John Doe")
    end
    
    it "returns nil if no student is found with the given id" do
      repo = Infrastructure::Repositories::StudentRepository.new
      found_student = repo.find_by_id(99999)
      expect(found_student).to be_nil
    end
  end
end
