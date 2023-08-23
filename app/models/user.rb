class User < ApplicationRecord

  attr_accessor :school_id

  enum role: [:admin, :school_admin, :student]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  has_many :school_users, dependent: :destroy
  has_many :schools, through: :school_users

  scope :school_admins, -> { where(role: :school_admin) }
  scope :students, -> { where(role: :student) }
  scope :admins, -> { where(role: :admin) }

  scope :accepted_only, -> { joins(:batch_users).where(batch_users: { aasm_state: 'accepted' }) }

  def full_name
    first_name + " " + last_name
  end

end
