class Batch < ApplicationRecord

  validates :name, presence: true
  belongs_to :course
  has_many :batch_users, dependent: :destroy
  has_many :students, class_name: 'User', foreign_key: 'user_id', through: :batch_users

  def status_for(student)
    enrollment_for(student).aasm_state.capitalize
  end

  def enrollment_pending_for?(student)
    enrollment_for(student).pending?
  end

  def enrollment_accepted_for?(student)
    enrollment_for(student).accepted?
  end

  def enrollment_for(student)
    batch_users.where(user_id: student.id).first
  end
end
