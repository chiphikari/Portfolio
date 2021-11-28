FactoryBot.define do
  factory :review do
    score {Faker::Number.between(from: 1, to: 5)}
    content{ Faker::Lorem.characters(number: 10) }
    association :post_summary
    association :user
  end
end