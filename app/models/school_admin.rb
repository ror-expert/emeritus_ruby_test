class SchoolAdmin
  include ActiveModel::Model
  include UserType

  def create
    @user ||= User.create(first_name: first_name, last_name: last_name, email: email, password: generate_password, role: User::roles[:school_admin])
  end

end