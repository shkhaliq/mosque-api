FactoryBot.define do
  factory :mosque do
    name { Faker::StarWars.character }
    publiclyAccessible false
  end
end
