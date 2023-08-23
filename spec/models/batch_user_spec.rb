require 'rails_helper'

RSpec.describe BatchUser, type: :model do
  subject { described_class.new(batch: build(:batch), student: build(:user)) }

  describe "Validations" do
    it "is not valid without batch" do
      subject.batch = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without student" do
      subject.student = nil
      expect(subject).to_not be_valid
    end

    it "is valid with batch & student" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:batch) }
    it { should belong_to(:student) }
  end
end
