require 'rails_helper'

RSpec.describe 'Tagモデルのテスト', type: :model do
  let(:tag) {create(:tag)}

  describe "タグ名" do
    it "タグ名がある場合、有効であること" do
      expect(tag).to be_valid
    end

    it "タグ名がない場合、無効であること" do
      tag.tag_name = nil
      expect(tag).to be_invalid
      expect(tag.errors[:tag_name]).to include("を入力してください")
    end
  end
end