class BatchUser < ApplicationRecord
  include AASM

  belongs_to :batch
  belongs_to :student, class_name: 'User', foreign_key: 'user_id'

  aasm do
    state :pending, initial: true
    state :accepted, :rejected

    event :accept do
      transitions from: :pending, to: :accepted
    end

    event :reject do
      transitions from: [:pending, :accepted], to: :rejected
    end
  end
end
