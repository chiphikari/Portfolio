class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_summary = PostSummary.find(params[:post_summary_id])
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.post_summary_id = @post_summary.id
    review_count = Review.where(post_summary: params[:post_summary_id]).where(user_id: current_user.id).count
    if review.valid?
      if review_count < 1
        review.save
        @reviews = @post_summary.reviews.includes(:user)
      else
        flash[:notice] = 'レビューの投稿は一度までです'
        redirect_to request.referer
      end
    else
      flash[:alert] = 'レビューの保存に失敗しました。レビューの評価を入力してください'
      redirect_to request.referer
    end
  end

  def destroy
    # post_summaryのidを持ってきたい
    @post_summary = PostSummary.find(params[:post_summary_id])
    # reviewのidを持ってきたい
    @review = Review.find(params[:id]).destroy
    redirect_to post_summary_path(@post_summary.id)
  end

  def review_params
    params.require(:review).permit(:score, :content)
  end
end
