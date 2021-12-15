require 'rails_helper'

describe "ログイン後のテスト" do

  before do
    @user = create(:user)
    @post = FactoryBot.create(:post_summary, user_id: @user.id)
    @post_house_params = FactoryBot.attributes_for(:post_house)
    @post_outside_params = FactoryBot.attributes_for(:post_outside)
    @post_images = FactoryBot.attributes_for(:post_image)
    @tag = FactoryBot.create(:tag)
    @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
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
        is_expected.to eq '/users/' + @user.id.to_s
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


  describe "投稿一覧表示テスト" do
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
        expect(page).to have_link @post.title, href: post_summary_path(@post)
      end
      it "ヘッドラインが表示される" do
        expect(page).to have_content @post.headline
      end
      it "紹介文が表示される" do
        expect(page).to have_content @post.introduction
      end
      it "投稿者が表示される" do
        expect(page).to have_content @post.user.user_name
      end
      it "投稿者画像が表示される" do
        expect(page).to have_content @post.user.profile_image
      end
    end
  end

  describe "新規投稿表示テスト" do
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

  describe "投稿編集表示テスト" do
    before do
      visit post_summary_path(@post)
    end
    it "編集画面遷移" do
      click_link '投稿内容を編集する'
      expect(current_path).to eq '/post_summaries/' + @post.id.to_s + '/edit'
    end
    it "タイトル編集フォームが表示される" do
      visit edit_post_summary_path(@post)
      expect(page).to have_field 'post_summary[title]', with: @post.title
    end
    it "ヘッドライン編集フォームが表示される" do
      visit edit_post_summary_path(@post)
      expect(page).to have_field 'post_summary[headline]', with: @post.headline
    end
    it "紹介文編集フォームが表示される" do
      visit edit_post_summary_path(@post)
      expect(page).to have_field 'post_summary[introduction]', with: @post.introduction
    end
    it "更新するボタンが表示される" do
      visit edit_post_summary_path(@post)
      expect(page).to have_button '更新する'
    end
  end

  describe "投稿削除テスト" do
    before do
      visit post_summary_path(@post)
      click_link '投稿内容を削除する'
    end
    it '正しく削除される' do
      expect(PostSummary.where(id: @post.id).count).to eq 0
    end
    it 'リダイレクト先が、投稿一覧画面になっている' do
      expect(current_path).to eq post_summaries_path
    end
  end

  describe "投稿詳細画表示テスト" do
    before do
      visit post_summary_path(@post)
    end
    it "画像が表示される" do
      expect(page).to have_content ''
    end
    it "ヘッドラインが表示される" do
      expect(page).to have_content @post.headline
    end
    it "紹介文が表示される" do
      expect(page).to have_content @post.introduction
    end
    it "投稿者が表示される" do
      expect(page).to have_content @post.user.user_name
    end
    it "投稿者画像が表示される" do
      expect(page).to have_content @post.user.profile_image
    end
  end

  describe "ユーザー詳細画面表示テスト" do
    before do
      visit user_path(@user)
    end
    it "URLが正しい" do
      expect(current_path).to eq '/users/' + @user.id.to_s
    end
    it "自分のユーザー名が表示される" do
      expect(page).to have_content @user.user_name
    end
    it "自分のユーザー名が表示される" do
      expect(page).to have_content @user.email
    end
    it "編集リンクがある" do
      expect(page).to have_link "編集する"
    end
  end

  describe "ユーザー情報編集画面表示テスト" do
    before do
      visit edit_user_path(@user)
    end
    it "URLが正しい" do
      expect(current_path).to eq '/users/' + @user.id.to_s + '/edit'
    end
    it '名前編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[user_name]', with: @user.user_name
    end
    it '名前編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[email]', with: @user.email
    end
    it '変更保存ボタンが表示される' do
      expect(page).to have_button '変更を保存する'
    end
    it '退会ボタンが表示される' do
      expect(page).to have_link '退会する'
    end
  end
end