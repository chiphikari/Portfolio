FactoryBot.define do
  factory :post_summary do
    title { Faker::Lorem.characters(number: 10) }
    headline { Faker::Lorem.characters(number: 50) }
    introduction { Faker::Lorem.characters(number: 50) }
    user
    category {PostSummary.categories.keys.sample}
    after(:build) do |post_summary|
      post_summary.post_house << FactoryBot.build(:post_house, post_summary: post_summary)
      post_summary.post_outside << FactoryBot.build(:post_outside, post_summary: post_summary)
    end
  end
  
  factory :post_house do
    link{ Faker::Lorem.characters(number: 10) }
  end
  
  factory :post_outside do
    address { Gimei.address.kanji }
  end
  
end