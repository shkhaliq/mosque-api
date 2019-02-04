FactoryBot.define do
  factory :mosque do
    name { Faker::StarWars.character }
    publicly_accessible false
  end
end
