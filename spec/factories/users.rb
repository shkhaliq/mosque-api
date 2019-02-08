FactoryBot.define do
  factory :user do
    name { Faker::StarWars.character }
    email { Faker::Internet.email }
    password { 'fakepassword' }
  end
end