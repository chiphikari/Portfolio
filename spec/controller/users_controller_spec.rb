require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "show" do
    context "authorized user" do
      before do
        @user = create(:user)
        @another_user = create(:user)
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

      it "not responds when other user" do
        sign_in @another_user
        get :show, params: {id: @user.id, bookmark: @bookmarks }
        expect(response).to_not be_success
      end

      it "returns a 302 response when other user" do
        sign_in @another_user
        get :show, params: {id: @user.id, bookmark: @bookmarks }
        expect(response).to have_http_status "302"
      end

      it " redirect_to root when other user" do
        sign_in @another_user
        get :show, params: {id: @user.id, bookmark: @bookmarks }
        expect(response).to redirect_to "/users/2"
      end
    end

    context "unauthorized user" do
      before do
        @user = create(:user)
      end
      it "return 302" do
        get :show, params: {id: @user.id}
        expect(response).to have_http_status "302"
      end
      it "redirect_to sign in" do
        get :show, params: {id: @user.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "edit" do
    before do
      @user = create(:user)
      @another_user = create(:user)
    end
    context "authorized user" do
      it "responds successfully" do
        sign_in @user
        get :edit, params: {id: @user.id}
        expect(response).to be_success
      end
      it "return a 200 response" do
        sign_in @user
        get :edit, params: {id: @user.id}
        expect(response).to have_http_status "200"
      end
      it "another user cannot edit" do
        sign_in @another_user
        get :edit, params: {id: @user.id}
        expect(response).to_not be_success
      end
      it "redirect_to root when another user" do
        sign_in @another_user
        get :edit, params: {id: @user.id}
        expect(response).to redirect_to "/users/2"
      end
    end
    context "unauthorized user" do
      it "returns 302" do
        get :edit, params: {id: @user.id}
        expect(response).to have_http_status "302"
      end

      it "redirect_to sign in" do
        get :edit, params: {id: @user.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "update" do
    before do
      @user = create(:user, user_name: "Old name")
      @another_user = FactoryBot.create(:user)
    end
    context "authorized user" do
      it "update successfully" do
        user_params = FactoryBot.attributes_for(:user, user_name: "New name")
        sign_in @user
        patch :update, params: {id: @user.id, user: user_params}
        expect(@user.reload.user_name).to eq "New name"
      end
      it "redirect_to show" do
        user_params = FactoryBot.attributes_for(:user, user_name: "New name")
        sign_in @user
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to redirect_to user_path(@user.id)
      end
      it "another user cannot update" do
        user_params = FactoryBot.attributes_for(:user, user_name: "New name")
        sign_in @another_user
        patch :update, params: {id: @user.id, user: user_params}
        expect(@user.reload.user_name).to eq "Old name"
      end
      it "redirects to show" do
        user_params = FactoryBot.attributes_for(:user, user_name: "New name")
        sign_in @another_user
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to redirect_to redirect_to user_path(@another_user.id)
      end
    end

    context "unauthorized user" do
      it "return 302" do
        patch :update,  params: {id: @user.id}
        expect(response).to have_http_status "302"
      end
      it "redirect_to sign in" do
        patch :update, params: {id: @user.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "withdraw" do
    before do
      @user = create(:user)
    end
    it "responds successfully" do
      sign_in @user
      @user.update(status: false)
      expect(@user.reload.status).to eq false
    end
  end
end