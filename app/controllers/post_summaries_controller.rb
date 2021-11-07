class PostSummariesController < ApplicationController

    def index
        # params:[:category]はlink_toの（category: 0..)のcategoryと連携している。なのでparams:[:hoge]としてもlink_toを（hoge: 0..)にしても動作はする
        @post_summaries = PostSummary.where(category: params[:category])
    end

    def new

    end

    def house
        @post_summary = PostSummary.new
        @post_summary.build_post_house
    end

    def outside
        @post_summary = PostSummary.new
        @post_summary.build_post_outside
    end


    def create
        post_summary = PostSummary.new(post_summary_params)
        # belongs_toでユーザーを関連つけしているためuser.idがnilになる
        post_summary.user = current_user
        if post_summary.save
            flash[:notice] = "投稿できました！！"
            redirect_to post_summary_path(post_summary.id)
        else
            render :edit
        end
    end

    def show
        @post_summary = PostSummary.find(params[:id])
        @user = @post_summary.user
    end

    private

    def post_summary_params
        params.require(:post_summary).permit(:headline, :introduction, :title, :category, post_house_attributes: [:link], post_outside_attributes: [:address], post_images_images: [],)
    end

end
