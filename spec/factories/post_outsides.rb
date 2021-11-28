FactoryBot.define do
  factory :post_outside do
    address { Gimei.address.kanji }
  end
end