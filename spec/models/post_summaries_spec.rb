require 'rails_helper'

RSpec.describe 'PostSummaryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_summary.valid? }

    let(:user) { create(:user) }
    let!(:post_summary) { build(:post_summary, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post_summary.title = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字は○' do
        post_summary.title = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
        expect(post_summary.errors.full_messages).to eq []
      end
      it '50文字以下であること: 51文字は×' do
        post_summary.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
        expect(post_summary.errors.full_messages).to eq ["タイトルは50文字以内で入力してください"]
      end
    end

    context 'headlineカラム' do
      it '空欄でないこと' do
        post_summary.headline = ''
        is_expected.to eq false
      end
      it '100文字以下であること: 100文字は○' do
        post_summary.headline = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
        expect(post_summary.errors.full_messages).to eq []
      end
      it '100文字以下であること: 101文字は×' do
        post_summary.headline = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
        expect(post_summary.errors.full_messages).to eq ["ヘッドラインは100文字以内で入力してください"]
      end
    end

    context 'introductionカラム' do
      it '空欄でないこと' do
        post_summary.introduction = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字は○' do
        post_summary.introduction = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
        expect(post_summary.errors.full_messages).to eq []
      end
      it '500文字以下であること: 501文字は×' do
        post_summary.introduction = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
        expect(post_summary.errors.full_messages).to eq ["紹介文は500文字以内で入力してください"]
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'モデルとの関係' do
      it 'N:1となっている' do
        expect(PostSummary.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it '1:Nとなっている' do
        expect(PostSummary.reflect_on_association(:reviews).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(PostSummary.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(PostSummary.reflect_on_association(:favorites).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(PostSummary.reflect_on_association(:post_tags).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(PostSummary.reflect_on_association(:tags).macro).to eq :has_many
      end
      it '1:1となっている' do
        expect(PostSummary.reflect_on_association(:post_outside).macro).to eq :has_one
      end
      it '1:Nとなっている' do
        expect(PostSummary.reflect_on_association(:post_house).macro).to eq :has_one
      end
      it '1:Nとなっている' do
        expect(PostSummary.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end
  end
  
end