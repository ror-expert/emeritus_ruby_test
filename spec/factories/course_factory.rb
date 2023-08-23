FactoryBot.define do
  factory :course do
    name { Faker::ProgrammingLanguage.name }
    description {  Faker::Lorem.paragraph }
    school
  end

  factory :school do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
  end

  factory :batch do
    name { Faker::Name.name }
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'demouser' }

    trait :school_admin do
      role { User.roles[:school_admin] }
    end

    trait :admin do
      role { User.roles[:admin] }
    end
  end

  factory :school_user do
    user nil
    school nil
  end

end
