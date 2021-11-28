require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  let(:favorite) {create(:favorite)}

 context 'バリデーションテスト' do
    it "userとpost_summaryがあれば保存可能" do
      expect(favorite).to be_valid
    end
    it "user_idがなければ無効" do
      favorite.user_id = nil
      favorite.valid?
      expect(favorite.errors[:user_id]).to include("を入力してください")
    end
    it "post_summary_idがなければ無効" do
      favorite.post_summary_id = nil
      favorite.valid?
      expect(favorite.errors[:post_summary_id]).to include("を入力してください")
    end
    it "user_idが同じでもpost_summary_idが違うと保存可能" do
      favorite = FactoryBot.create(:favorite)
      expect(FactoryBot.create(:favorite, user_id: favorite.user_id)).to be_valid
    end
    it "post_summary_idが同じでもuser_idが違うと保存できる" do
      favorite = FactoryBot.create(:favorite)
      expect(FactoryBot.create(:favorite, post_summary_id: favorite.post_summary_id)).to be_valid
    end
  end

end