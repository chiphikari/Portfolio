class PostSummariesController < ApplicationController
    def new
        @post_summary = PostSummary.new
    end
    
    private
    
    def post_summary_params
    params.require(:post_summary).permit(:headline, :introduction, :title, :image, :category, :url, :address)
    end
    
end
