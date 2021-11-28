require 'rails_helper'

RSpec.describe 'Bookmarkモデルのテスト', type: :model do
  before do
    @bookmark = FactoryBot.build(:bookmark)
  end

  context 'バリデーションテスト' do
    it "userとpost_summaryがあれば保存可能" do
      expect(FactoryBot.create(:bookmark)).to be_valid
    end
    it "user_idがなければ無効" do
      @bookmark.user_id = nil
      @bookmark.valid?
      expect(@bookmark.errors[:user_id]).to include("を入力してください")
    end
    it "post_summary_idがなければ無効" do
      @bookmark.post_summary_id = nil
      @bookmark.valid?
      expect(@bookmark.errors[:post_summary_id]).to include("を入力してください")
    end
    it "user_idが同じでもpost_summary_idが違うと保存可能" do
      bookmark = FactoryBot.create(:bookmark)
      expect(FactoryBot.create(:bookmark, user_id: bookmark.user_id)).to be_valid
    end
    it "post_summary_idが同じでもuser_idが違うと保存できる" do
      bookmark = FactoryBot.create(:bookmark)
      binding.pry
      expect(FactoryBot.create(:bookmark, post_summary_id: bookmark.post_summary_id)).to be_valid
    end
  end

end