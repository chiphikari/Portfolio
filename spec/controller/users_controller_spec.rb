require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "show" do
    before do
      @user = create(:user)
      @post_summary = FactoryBot.create(:post_summary)
      @bookmarks = create(:bookmark, user_id: @user.id, post_summary_id: @post_summary.id)
    end

    it "responds successfully" do
      sign_in @user
      get :show, params: {id: @user.id, bookmark: @bookmarks }
      expect(response).to be_success
    end

    it "returns a 200 response" do
      sign_in @user
      get :show, params: {id: @user.id, bookmark: @bookmarks }
      expect(response).to have_http_status "200"
    end
  end

end