require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) {create(:user)}
  let(:post_summary) {create(:post_summary)}
  let(:favorite) {create(:favorite, user_id: user.id, post_summary_id: post_summary.id)}

  describe "#create" do
    before do
      sign_in user
    end
    it "responds successfully" do
      post :create, format: :js,
      params: { post_summary_id: post_summary.id, id: favorite.id }
      expect(response.content_type).to eq 'text/javascript'
    end
    it "add a new favorite" do
      expect { post :create, format: :js, params: { post_summary_id: post_summary.id, id: favorite.id } }.to change{ Favorite.count }.by(1)
    end
  end

  describe "#destroy" do
    before do
      sign_in user
    end
    it "responds successfully" do
      delete :destroy, format: :js,
      params: { post_summary_id: post_summary.id, id: favorite.id }
      expect(response.content_type).to eq 'text/javascript'
    end
    it "remove favorite" do
      favorite = create(:favorite, user_id: user.id, post_summary_id: post_summary.id)
      expect { delete :destroy, format: :js, params: { post_summary_id: post_summary.id, user_id: user.id, id: favorite.id } }.to change{ Favorite.count }.by(-1)
    end
  end
end