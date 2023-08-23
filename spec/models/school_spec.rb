require 'rails_helper'

RSpec.describe School, type: :model do

  subject { described_class.new(name: "test school", address: "Lorem ipsum") }

  describe "Validations" do
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a address" do
      subject.address = nil
      expect(subject).to_not be_valid
    end

    it "is valid with name & address attributes" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:courses) }
    it { should have_many(:school_users) }
    it { should have_many(:users).through(:school_users) }
  end

end
