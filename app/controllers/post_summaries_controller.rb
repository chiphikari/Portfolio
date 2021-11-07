class PostSummariesController < ApplicationController
    def new
        
    end

    def post_house
        @post_summary = PostSummary.new
        @post_summary.build_post_house
    end

    def post_outside
        @post_summary = PostSummary.new
        @post_summary.build_post_outside
    end


    def create
        post_summary = PostSummary.new(post_summary_params)
        # belongs_toでユーザーを関連つけしているためuser.idがnilになる
        post_summary.user = current_user
        if post_summary.save
          redirect_to post_summary_path(post_summary.id)
        else
            # todo
        end
    end

    def show
        @post_summary = PostSummary.find(params[:id])
    end

    private

    def post_summary_params
        params.require(:post_summary).permit(:headline, :introduction, :title, :category, post_house_attributes: [:link], post_outside_attributes: [:address], post_images_images: [],)
    end

end
