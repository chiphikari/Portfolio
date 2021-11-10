class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @post_summary = PostSummary.find(params[:post_summary_id])
    @review.user = current_user
    @review.post_summary_id = @post_summary.id
    if @review.save!
      redirect_to post_summary_path(@post_summary.id)
    else
      render :show
    end
  end

  def destroy
    @post_summary = PostSummary.find(params[:id])
    @review = Review.find(params[:post_summary_id]).destroy
    redirect_to post_summary_path(@post_summary.id)
  end

  def review_params
    params.require(:review).permit(:score, :content)
  end
end
