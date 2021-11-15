FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    status { Faker::Lorem.word }
    description { Faker::Lorem.word }
    category
  end
end
