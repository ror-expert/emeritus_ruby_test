class Student
  include ActiveModel::Model
  include UserType

  def create
    @user ||= User.create(first_name: first_name, last_name: last_name, email: email, password: generate_password, role: User::roles[:student])
  end

  def batch_enrolled?(batch)
    batch_user = batch.batch_users.create!(student: @user)
    batch_user.accept!
  end

end