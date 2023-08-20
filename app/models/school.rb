class School < ApplicationRecord

  validates :name, :address, presence: true

  has_many :school_users, dependent: :destroy
  has_many :users, through: :school_users
  has_many :courses, dependent: :destroy
end
