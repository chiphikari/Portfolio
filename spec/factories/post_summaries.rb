FactoryBot.define do
  factory :post_summary do
    title { Faker::Lorem.characters(number: 10) }
    headline { Faker::Lorem.characters(number: 50) }
    introduction { Faker::Lorem.characters(number: 50) }
    association :user
    category {PostSummary.categories.keys.sample}
    after(:create) do |post_summary|
      create :post_house, post_summary: post_summary
      create :post_outside, post_summary: post_summary
      create_list(:post_tag, 1, post_summary: post_summary, tag: create(:tag))
    end
  end

end