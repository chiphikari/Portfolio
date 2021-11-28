require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  let!(:user) {create(:user)}
  let!(:post_summary) {create(:post_summary)}
  let(:review) {build(:review, user_id: user.id, post_summary_id: post_summary.id)}

  context 'カラムバリデーションテスト' do
    it 'scoreは空欄でないこと' do
      review.score = ''
      expect(review).to be_invalid
    end

    it 'Contentは50文字以下であること: 50文字は○' do
      review.content = Faker::Lorem.characters(number: 50)
      expect(review).to be_valid
      expect(review.errors.full_messages).to eq []
    end

    it 'contentは50文字以下であること: 51文字は✕' do
      review.content = Faker::Lorem.characters(number: 51)
      expect(review).to be_invalid
      expect(review.errors.full_messages).to eq ["Contentは50文字以内で入力してください"]
    end
  end

  context 'バリデーションテスト' do
    it "userとpost_summaryがあれば保存可能" do
      expect(review).to be_valid
    end
    it "userがなければ無効" do
      review.user_id = nil
      review.valid?
      expect(review.errors[:user_id]).to include("を入力してください")
    end

    it "post_summary_idがなければ無効" do
      review.post_summary_id = nil
      review.valid?
      expect(review.errors[:post_summary_id]).to include("を入力してください")
    end

    it "post_summary_idが同じでもuser_idが違うと保存できる" do
      review = FactoryBot.create(:review)
      expect(FactoryBot.create(:review, post_summary_id: review.post_summary_id)).to be_valid
    end

    it "user_idが同じでもpost_summary_idが違うと保存可能" do
      review = FactoryBot.create(:review)
      expect(FactoryBot.create(:review, post_summary_id: review.post_summary_id)).to be_valid
    end
  end

end