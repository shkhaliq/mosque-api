FactoryBot.define do
  factory :salah do
    name { Faker::StarWars.character }
    begins { Faker::StarWars.character }
    iqamah { "" }
    mosque { nil }
  end
end
