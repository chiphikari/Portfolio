FactoryBot.define do
  factory :bookmark do
    association :post_summary
    association :user
  end
end