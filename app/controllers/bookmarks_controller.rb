class BookmarksController < ApplicationController
  before_action :post_summary_params

  def create
    bookmark = @post_summary.bookmarks.new(user_id: current_user.id)
    bookmark.save
  end

  def destroy
    bookmark = @post_summary.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
      bookmark.destroy
    else
      redirect_to request.referer
    end
  end

  private

  def post_summary_params
    @post_summary = PostSummary.find(params[:post_summary_id])
  end
end
