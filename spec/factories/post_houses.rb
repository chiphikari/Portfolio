FactoryBot.define do
  factory :post_house do
    link{ Faker::Lorem.characters(number: 10) }
  end
end