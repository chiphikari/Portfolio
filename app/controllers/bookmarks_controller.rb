class BookmarksController < ApplicationController
  before_action :post_summary_params

  def create
    Bookmark.create(user_id: current_user.id, post_summary_id: params[:post_summary_id])
  end

  def destroy
    Bookmark.find_by(user_id: current_user.id, post_summary_id: params[:post_summary_id]).destroy
  end

  private

  def post_summary_params
    @post_summary = PostSummary.find(params[:post_summary_id])
  end
end
