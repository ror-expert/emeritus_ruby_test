class Course < ApplicationRecord

  validates :name, :description, presence: true
  belongs_to :school
  has_many :batches, dependent: :destroy
end
