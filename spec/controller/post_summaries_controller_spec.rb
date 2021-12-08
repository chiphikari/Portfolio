require 'rails_helper'

RSpec.describe PostSummariesController, type: :controller do
  describe "Not authenticated" do
    context "#index" do
      it "responds successfully" do
        get :index
        expect(response).to be_success
      end

      it "returns a 200 response" do
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "#show" do
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
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        sign_in @user
        @post_summary = FactoryBot.create(:post_summary)
      end

      it "success to request" do
        expect {
          post :create, params: {
            post_summary: {
              title: "test",
              headline: "testtest",
              introduction: "testtesttest",
              category: "動画・映画",
              user_id: 1,
              tag_name: "test",
              link: "test",
              address: "東京"
            }
          }
        }.to change(@user.post_summaries, :count).by(1)
      end

      it "redirect_to #show" do
        post :create, params: {
          post_summary: {
            title: "test",
            headline: "testtest",
            introduction: "testtesttest",
            category: "動画・映画",
            user_id: 1,
            tag_name: "test",
            link: "test",
            address: "東京"
          }
        }
        expect(response).to redirect_to "/post_summaries/2"
      end
    end
    
    
  end
end