FactoryBot.define do
  factory :salah do
    name { Faker::StarWars.character }
    begins { Faker::StarWars.character }
    iqamah { Faker::Date.between(2.days.ago, Date.today) }
    mosque { nil }
  end
end
