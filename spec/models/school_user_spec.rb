require 'rails_helper'

RSpec.describe SchoolUser, type: :model do
  subject { described_class.new(school: build(:school), user: build(:user)) }

  describe "Validations" do
    it "is not valid without school" do
      subject.school = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without user" do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it "is valid with school & user" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:school) }
  end
end
