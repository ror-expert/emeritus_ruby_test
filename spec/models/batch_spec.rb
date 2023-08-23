require 'rails_helper'

RSpec.describe Batch, type: :model do
  let(:course) { create(:course) }
  let(:subject) { described_class.new(name: "test batch", course: course) }

  describe "Validations" do
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without course" do
      subject.course = nil
      expect(subject).to_not be_valid
    end

    it "is valid with attributes" do
      expect(subject).to be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:course) }
    it { should have_many(:batch_users) }
    it { should have_many(:students).through(:batch_users) }
  end
end
