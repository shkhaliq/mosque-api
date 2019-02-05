FactoryBot.define do
  factory :mosque do
    name { Faker::StarWars.character }
    publicly_accessible { Faker::Boolean.boolean }
  end
end
