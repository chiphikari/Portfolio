require 'rails_helper'

RSpec.describe PostSummariesController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#show" do
    before do
      @user = create(:user)
      @post_summary = FactoryBot.create(:post_summary, user_id: @user.id)
      @post_outside_params = FactoryBot.attributes_for(:post_outside)
      @post_images = FactoryBot.attributes_for(:post_image)
      @tag = FactoryBot.create(:tag)
      @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
      @params =  {:post_summary => @params_nested }
    end
    it "responds successfully" do
      get :show, params: {id: @post_summary.id, post_summary: @params_nested}
      expect(response).to be_success
    end
    it "returns a 200 response" do
      get :show, params: {id: @post_summary.id, post_summary: @params_nested}
      expect(response).to have_http_status "200"
    end
  end

  describe "#new" do
    before do
      @user = FactoryBot.create(:user)
      @post_summary = FactoryBot.create(:post_summary)
    end
    context "authorized user" do
      it "responds successfully" do
        sign_in @user
        get :new
        expect(response).to be_success
      end
    end

    context "unauthorized user" do
      it "responds fails" do
        get :new
        expect(response).to_not be_success
      end

      it "returns a 302 when not sign in" do
        get :new
        expect(response).to have_http_status "302"
      end

      it "redirect_to login page" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    context "authorized user" do
      before do
        @user = create(:user)
        sign_in @user
        @post_summary = FactoryBot.create(:post_summary, user_id: @user.id)
        @post_house_params = FactoryBot.attributes_for(:post_house)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = FactoryBot.create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
      end

      it "add new" do
        expect do
          post :create, params: {id: @post_summary.id, post_summary: @params_nested}
        end.to change(PostSummary, :count).by(1) and change(PostHouse, :count).by(1) and change(PostOutside, :count).by(1)
      end

      it "redirect_to show" do
        post :create, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to "/post_summaries/2"
      end
    end
    context "invalid" do
      before do
        @user = create(:user)
        @post_summary = FactoryBot.create(:post_summary, user_id: @user.id)
        @post_house_params = FactoryBot.attributes_for(:post_house)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = FactoryBot.create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, title: nil, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
      end
      it "nil does not add" do
        expect do
          sign_in @user
          post :create, params: {id: @post_summary.id, post_summary: @params_nested}
        end.to_not change(@user.post_summaries, :count)
      end
    end
    context "unauthorized user" do
      it "return 302" do
        post :create
        expect(response).to have_http_status "302"
      end
      it "redirect_to sign in" do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#edit" do
    before do
      @user = create(:user)
      @another_user = FactoryBot.create(:user)
      @post_summary = FactoryBot.create(:post_summary, user_id: @user.id)
      @post_outside_params = FactoryBot.attributes_for(:post_outside)
      @post_images = FactoryBot.attributes_for(:post_image)
      @tag = FactoryBot.create(:tag)
      @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
    end
    context "authorized user" do
      it "responds sucessfully" do
        sign_in @user
        get :edit, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to be_success
      end

      it "returns a 200 response" do
        sign_in @user
        get :edit, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to have_http_status "200"
      end

      it "another user cannot open page" do
        sign_in @another_user
        get :edit, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to_not be_success
      end

      it "redirect_to root when another user" do
        sign_in @another_user
        get :edit, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to root_path
      end
    end
    context "unauthorized user" do
      it "returns 302" do
        get :edit, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to have_http_status "302"
      end

      it "redirect_to sign_in" do
        get :edit, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "authorized user" do
      before do
        @user = create(:user)
        @post_summary = FactoryBot.create(:post_summary, user: @user)
        @post_house_params = FactoryBot.attributes_for(:post_house)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = FactoryBot.create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
      end
      it "updates post_summary sucessfully" do
        @params_nested = FactoryBot.attributes_for(:post_summary, title: "New Post Name", post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag)
        sign_in @user
        patch :update, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(@post_summary.reload.title).to eq "New Post Name"
      end

      it "update post_house successfully" do
        @post_house_params = FactoryBot.attributes_for(:post_house, link: "test123")
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag)
        sign_in @user
        patch :update, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(@post_house_params).to eq :link => "test123"
      end

      it "update post_house successfully" do
        @post_outside_params = FactoryBot.attributes_for(:post_outside, address: "東京")
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag)
        sign_in @user
        patch :update, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(@post_outside_params).to eq :address => "東京"
      end

      it "redirect_to show" do
        @params_nested = FactoryBot.attributes_for(:post_summary, title: "New Post Name", post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag)
        sign_in @user
        patch :update, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to post_summary_path(@post_summary.id)
      end
    end
     context "if logged in user updates another user" do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @post_summary = FactoryBot.create(:post_summary, user: other_user, title: "Same Old Name")
        @post_house_params = FactoryBot.attributes_for(:post_house)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = FactoryBot.create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
      end

      it "does not update" do
        @params_nested = FactoryBot.attributes_for(:post_summary, title: "New Name", post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
        sign_in @user
        patch :update, params: { id: @post_summary.id, post_summary: @params_nested }
        expect(@post_summary.reload.title).to eq "Same Old Name"
      end

      it "redirects to show" do
        sign_in @user
        patch :update, params: { id: @post_summary.id, post_summary: @params_nested }
        expect(response).to redirect_to post_summary_path(@post_summary.id)
      end
    end
    context "invalid update" do
      before do
        @user = FactoryBot.create(:user)
        @post_summary = FactoryBot.create(:post_summary, user: @user)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = FactoryBot.create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
      end

      it "return 302" do
        patch :update, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to have_http_status "302"
      end

      it "redirect_to root_path" do
        patch :update, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @post_summary = FactoryBot.create(:post_summary, user: @user)
      end

      it "deletes a task" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @post_summary.id }
        }.to change(@user.post_summaries, :count).by(-1)
      end

      it "redirects to index" do
        sign_in @user
        delete :destroy, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to post_summaries_path
      end
    end

    context "if logged in user delete another user" do
      before do
        @user = create(:user)
        other_user = create(:user)
        @post_summary = FactoryBot.create(:post_summary, user: other_user)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = FactoryBot.create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
      end

      it "does not delete" do
        sign_in @user
        expect{
          delete :destroy, params: {id: @post_summary.id, post_summary: @params_nested}
        }.to_not change(PostSummary, :count)
      end

      it "redirects to the dashboard" do
        sign_in @user
        delete :destroy, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to root_path
      end
    end

    context "as a user not to login" do
      before do
        @post_summary = FactoryBot.create(:post_summary)
      end

      it "returns a 302 response" do
        delete :destroy, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        delete :destroy, params: {id: @post_summary.id, post_summary: @params_nested}
        expect(response).to redirect_to new_user_session_path
      end

      it "does not delete" do
        expect {
          delete :destroy, params: {id: @post_summary.id, post_summary: @params_nested}
        }.to_not change(PostSummary, :count)
      end
    end
  end
end