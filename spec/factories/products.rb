FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    status { Faker::Lorem.word }
    description { Faker::Lorem.sentence(word_count: 5) }
    category
  end
end
