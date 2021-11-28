require 'rails_helper'

RSpec.describe 'PostSummary投稿のテスト', type: :request do
  describe 'ログインのテスト' do
    before do
      @user = create(:user)
    end

    it '投稿ページがアクセス可能なこと' do
      sign_in @user
      get house_post_summaries_path
      expect(response.status).to eq 200
    end
  end

  describe '投稿テスト' do
    before do
      @user = create(:user)
      sign_in @user
      @post_house_params = FactoryBot.attributes_for(:post_house)
      @post_outside_params = FactoryBot.attributes_for(:post_outside)
      @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: nil)
    end

    it 'リクエストが成功すること' do
      post post_summaries_path, params: @params_nested
      expect(response.status).to eq 302
    end
  end


    # it 'PostSummaryとPostHouseが新規作成されること' do
    #   expect(PostSummary.count).to eq 0
    #   post post_summaries_url , params: @params_nested
    #   expect(response.status).to eq 302
    #   expecy(current_path).to eq post_summaries_path
    #   expect(PostSummary.count).to eq 1
    #   # expect do
    #     # binding.pry
    #     # post post_summaries_path, params: @params_nested
    #     # binding.pry
    #   # end .to change(PostSummary, :count).by(1) and change(PostHouse, :count).by(1)
    # end
end