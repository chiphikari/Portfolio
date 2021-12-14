require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:user) {create(:user)}
  let(:post_summary) {create(:post_summary)}
  let(:bookmark) {create(:bookmark, user_id: user.id, post_summary_id: post_summary.id)}

  describe "#create" do
    before do
      sign_in user
    end
    it "responds successfully" do
      post :create, format: :js,
      params: { post_summary_id: post_summary.id, id: bookmark.id }
      expect(response.content_type).to eq 'text/javascript'
    end
    it "add a new bookmark" do
      expect { post :create, format: :js, params: { post_summary_id: post_summary.id, id: bookmark.id } }.to change{ Bookmark.count }.by(1)
    end
  end

  describe "#destroy" do
    before do
      sign_in user
    end
    it "responds successfully" do
      delete :destroy, format: :js,
      params: { post_summary_id: post_summary.id, id: bookmark.id }
      expect(response.content_type).to eq 'text/javascript'
    end
    it "remove bookmark" do
      bookmark = create(:bookmark, user_id: user.id, post_summary_id: post_summary.id)
      expect { delete :destroy, format: :js, params: { post_summary_id: post_summary.id, user_id: user.id, id: bookmark.id } }.to change{ Bookmark.count }.by(-1)
    end
  end
end