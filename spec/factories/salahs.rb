FactoryBot.define do
  factory :salah do
    name { Faker::StarWars.character }
    begins { "" }
    iqamah { "" }
    mosque { nil }
  end
end
