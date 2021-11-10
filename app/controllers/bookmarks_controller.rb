class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_summary = PostSummary.find(params[:post_summary_id])
    @bookmark = @post_summary.bookmarks.new(user_id: current_user.id)
    if @bookmark.save
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post_summary = PostSummary.find(params[:post_summary_id])
    @bookmark = @post_summary.bookmarks.find_by(user_id: current_user.id)
    if @bookmark.present?
      @bookmark.destroy
    else
      redirect_to request.referer
    end
  end
end
