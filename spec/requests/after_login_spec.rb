require 'rails_helper'

describe "ログイン後のテスト" do
  let(:user) { create(:user) }
  let!(:post) { create(:post_summary, user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe "ヘッダーテスト" do
    context "リンクの内容を確認" do
      subject { current_path }

      it "このサイトについてを押すとAboutページへ遷移" do
        about_link = find_all('a')[0].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it "マイページを押すとユーザー詳細へ遷移" do
        mypage_link = find_all('a')[2].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it "新規投稿を押すと投稿ページへ遷移" do
        new_link = find_all('a')[3].native.inner_text
        new_link = new_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link new_link
        is_expected.to eq '/post_summaries/new'
      end
      it "投稿一覧をクリックすると投稿一覧ページへ遷移" do
        index_link = find_all('a')[4].native.inner_text
        index_link = index_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link index_link
        is_expected.to eq '/post_summaries'
      end
    end
  end


  describe "投稿一覧テスト" do
    before do
      visit post_summaries_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/post_summaries'
      end
      it "画像が表示される" do
        expect(page).to have_content ''
      end
      it "投稿タイトルのリンク先が正しい" do
        expect(page).to have_link post.title, href: post_summary_path(post)
      end
      it "ヘッドラインが表示される" do
        expect(page).to have_content post.headline
      end
      it "紹介文が表示される" do
        expect(page).to have_content post.introduction
      end
      it "投稿者が表示される" do
        expect(page).to have_content post.user.user_name
      end
      it "投稿者画像が表示される" do
        expect(page).to have_content post.user.profile_image
      end
    end
  end

  describe "新規投稿" do
    before do
      visit new_post_summary_path
      visit house_post_summaries_path
    end
    context "新規投稿フォームの確認" do
      it 'titleフォームが表示される' do
        expect(page).to have_field 'post_summary[title]'
      end
      it "ヘッドラインフォームが表示される" do
        expect(page).to have_field 'post_summary[headline]'
      end
      it "紹介文フォームが表示される" do
        expect(page).to have_field 'post_summary[introduction]'
      end

    end
  end
end