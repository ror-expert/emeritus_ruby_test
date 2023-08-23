require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    let(:user) { build(:user) }
  
    it "is not valid without a first_name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "is not valid without last_name" do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it "is not valid without email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is valid with attributes" do
      expect(user).to be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:schools) }
    it { should have_many(:schools).through(:school_users) }
  end

  describe "instance methods" do
    let(:user) { build(:user) }

    it "returns full name" do
      user.first_name = "Rajeev"
      user.last_name  = "K."
      expect(user.full_name).to eq("Rajeev K.")
    end
  end

  describe "enum" do
    it { should define_enum_for(:role).with([:admin, :school_admin, :student]) }
  end

  describe "scopes" do
    it "returns students" do
      student = create(:user)
      expect(User.students).to include(student)
      expect(User.students.count).to eq(1)
    end

    it "returns school admins" do
      school_admin = create(:user, :school_admin)
      expect(User.school_admins).to include(school_admin)
      expect(User.school_admins.count).to eq(1)
    end

    it "returns admins" do
      admin = create(:user, :admin)
      expect(User.admins).to include(admin)
      expect(User.admins.count).to eq(1)
    end
  end

end
