FactoryBot.define do
  factory :post_tag do
    association :post_summary
    association :tag
  end
end