class FavoritesController < ApplicationController
  before_action :post_summary_params

  def create
    Favorite.create(user_id: current_user.id, post_summary_id: params[:post_summary_id])
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, post_summary_id: params[:post_summary_id]).destroy
  end

  private

  def post_summary_params
    @post_summary = PostSummary.find(params[:post_summary_id])
  end

end
