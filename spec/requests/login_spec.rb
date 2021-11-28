require 'rails_helper'

describe 'トップ画面のテスト' do
  before do
    visit root_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/'
    end
    it 'Log inリンクの表示が正しい' do
      log_in_link = find_all('a')[2].native.inner_text
      expect(log_in_link).to match("ログイン")
    end
    it 'Log inリンクの内容が正しい' do
      log_in_link = find_all('a')[2].native.inner_text
      expect(page).to have_link log_in_link, href: new_user_session_path
    end
    it 'Sign upリンクの内容が正しい' do
      sign_up_link = find_all('a')[3].native.inner_text
      expect(sign_up_link).to match("新規登録")
    end
    it 'Sign upリンクの内容が正しい' do
      sign_up_link = find_all('a')[3].native.inner_text
      expect(page).to have_link sign_up_link, href: new_user_registration_path
    end
  end
end

describe 'ユーザー新規登録のテスト' do
  before do
    visit new_user_registration_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/sign_up'
    end
    it '新規登録と表示される' do
      expect(page).to have_content '新規登録'
    end
    it 'ユーザーネーム入力フォームが表示される' do
      expect(page).to have_field 'user[user_name]'
    end
    it 'メールアドレス入力フォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'パスワードフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'パスワード（確認用）フォームが表示される' do
      expect(page).to have_field 'user[password_confirmation]'
    end
    it '新規登録ボタンが表示される' do
      expect(page).to have_button '新規登録'
    end
  end

  context '新規登録成功のテスト' do
    before do
      fill_in 'user[user_name]', with: Faker::Lorem.characters(number: 10)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end

    it '正しく新規登録される' do
      expect { click_button '新規登録' }.to change(User.all, :count).by(1)
    end
    it '新規登録のリダイレクト先が、トップページになっている' do
      click_button '新規登録'
      expect(current_path).to eq '/'
    end
  end
end

describe 'ユーザログイン' do
  let(:user) {create(:user)}

  before do
    visit new_user_session_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/sign_in'
    end
    it 'ログインと表示される' do
      expect(page).to have_content 'ログイン'
    end
    it 'メールアドレスフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'パスワードフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'ログインボタンが表示される' do
      expect(page).to have_button 'ログイン'
    end
  end

  context 'ログイン成功のテスト' do
    before do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後のリダイレクト先が、トップページになっている' do
      expect(current_path).to eq '/'
    end
  end

  context 'ログイン失敗のテスト' do
    before do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/users/sign_in'
    end
  end
end

describe 'ユーザログアウトのテスト' do
  let(:user) {create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    logout_link = find_all('a')[5].native.inner_text
    logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
    click_link logout_link
  end

  context 'ログアウト機能のテスト' do
    it '正しくログアウトできている:　ログアウト後のリダイレクト先においてAbout画面のリンクが存在する' do
      expect(page).to have_link '', href: '/home/about'
    end
    it 'ログアウト後のリダイレクト先が、トップ画面' do
      expect(page).to eq '/'
    end
  end
end