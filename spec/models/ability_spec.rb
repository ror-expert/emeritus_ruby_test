require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability do
  
  describe "Admin" do
    let(:admin) { create(:user, :admin) }

    it "Checks for Abilities" do
      ability = Ability.new(admin)

      expect(ability).to be_able_to(:manage, School)
      expect(ability).to be_able_to(:manage, User)
      expect(ability).to be_able_to(:manage, Batch)
      expect(ability).to be_able_to(:manage, Student)
      expect(ability).to be_able_to(:manage, Course)
      expect(ability).not_to be_able_to(:enrollment, Student)
    end
  end

  describe "School Admin" do
    let(:school_admin) { create(:user, :school_admin) }

    it "Checks for Abilities" do
      ability = Ability.new(school_admin)

      expect(ability).to be_able_to([:read, :edit, :update], School)
      expect(ability).to be_able_to([:read, :edit, :update, :destroy, :create], Course)
      expect(ability).to be_able_to(:manage, Batch)
      expect(ability).to be_able_to(:manage, Student)
      expect(ability).not_to be_able_to(:enrollment, Student)
    end
  end

  describe "Student" do
    let(:student) { create(:user) }

    it "Checks for Abilities" do
      ability = Ability.new(student)

      expect(ability).to be_able_to(:read, School)
      expect(ability).to be_able_to(:read, Course)
      expect(ability).to be_able_to(:read, Batch)
      expect(ability).to be_able_to(:enrollment, Student)
    end
  end

end
