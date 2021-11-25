FactoryBot.define do
  factory :post_summary do
    title { Faker::Lorem.characters(number: 10) }
    headline { Faker::Lorem.characters(number: 50) }
    introduction { Faker::Lorem.characters(number: 50) }
    user
    category {PostSummary.categories.keys.sample}
  end
end