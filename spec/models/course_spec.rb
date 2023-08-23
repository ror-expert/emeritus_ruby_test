require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:school) { create(:school) }

  subject { described_class.new(name: "test course", description: "Lorem ipsum", school: school) }

  describe "Validations" do
    it "is not valid without a name attribute" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a description attribute" do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without school" do
      subject.school = nil
      expect(subject).to_not be_valid
    end

    it "is valid with attributes" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:batches) }
    it { should belong_to(:school) }
  end

end
