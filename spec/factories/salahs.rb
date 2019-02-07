FactoryBot.define do
  factory :salah do
    name { Faker::Name.unique.name }
    begins { Faker::Date.between(1.days.ago, Date.today) }
    iqamah { Faker::Date.between(2.days.ago, Date.today) }
    mosque { nil }
  end
end
