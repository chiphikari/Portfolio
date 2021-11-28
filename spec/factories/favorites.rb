FactoryBot.define do
  factory :favorite do
    association :post_summary
    association :user
  end
end