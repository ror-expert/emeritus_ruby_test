module UserType
  extend ActiveSupport::Concern

  included do
    attr_accessor :first_name, :last_name, :email, :school_id

    validates :first_name, :last_name, :email, :school_id, presence: true
    validate :check_email

    def created? 
      return false unless create.valid?
      @user.school_users.create!(school_id: school_id)
    end

    private
    
    def generate_password
      (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).shuffle.first(8).join
    end

    def check_email
      if User.where(email: email).present?
        self.errors.add(:email, 'is already taken!')
        false
      end
    end

  end
end