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
      @post_summary = FactoryBot.create(:post_summary)
    end
    it "responds successfully" do
      get :show, params: {id: @post_summary.id}
      expect(response).to be_success
    end
    it "returns a 200 response" do
      get :show, params: {id: @post_summary.id}
      expect(response).to have_http_status "200"
    end
  end

  describe "#new" do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
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
        @post_house_params = FactoryBot.attributes_for(:post_house)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
        @params =  {:post_summary => @params_nested }
      end

      it "add new" do
        expect do
          post :create, params:@params
        end.to change(PostSummary, :count).by(1) and change(PostHouse, :count).by(1) and change(PostOutside, :count).by(1)
      end

      it "redirect_to show" do
        post :create, params:@params
        expect(response).to redirect_to "/post_summaries/1"
      end
    end
    context "invalid" do
      before do
        @user = create(:user)
        sign_in @user
        @post_house_params = FactoryBot.attributes_for(:post_house)
        @post_outside_params = FactoryBot.attributes_for(:post_outside)
        @post_images = FactoryBot.attributes_for(:post_image)
        @tag = create(:tag)
        @params_nested = FactoryBot.attributes_for(:post_summary, title: nil, post_house_attributes: @post_house_params, post_outside_attributes: @post_outside_params, post_images_image: @post_images, tag_name: @tag )
        @params =  {:post_summary => @params_nested }
      end
      it "nil does not add" do
        expect do
          post :create, params:@params
        end.to_not change(@user.post_summaries, :count)
      end
    end
    context "unauthorized user" do
      it "return 302" do
        tag = create(:tag)
        post_summary_params = FactoryBot.attributes_for(:post_summary, tag_name: tag)
        post :create, params: {post_summary: post_summary_params}
        expect(response).to have_http_status "302"
      end
      it "redirect_to sign in" do
        tag = create(:tag)
        post_summary_params = FactoryBot.attributes_for(:post_summary, tag_name: tag)
        post :create, params: {post_summary: post_summary_params}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  
  
end