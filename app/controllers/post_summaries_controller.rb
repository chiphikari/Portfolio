class PostSummariesController < ApplicationController

    def index
        if params[:category].blank? && !user_signed_in?
            @post_summaries = PostSummary.all
        else
            if params[:category].blank? && user_signed_in?
                @post_summaries = PostSummary.where(user_id: current_user.id)
            else
                # params:[:category]はlink_toの（category: 0..)のcategoryと連携している。なのでparams:[:hoge]としてもlink_toを（hoge: 0..)にしても動作はする
                @post_summaries = PostSummary.where(category: params[:category])
            end
        end
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
        # binding.irb
        if post_summary.save!
            flash[:notice] = "投稿できました！！"
            redirect_to post_summary_path(post_summary.id)
        else
            render :new
        end
    end

    def show
        @post_summary = PostSummary.find(params[:id])
        @user = @post_summary.user
    end

    def edit
        @post_summary = PostSummary.find(params[:id])
        if @post_summary.user == current_user
            render :edit
        else
            redirect_to root_path
        end
    end

    def update
        @post_summary = PostSummary.find(params[:id])
        if @post_summary.update(post_summary_params)
            flash[:notice] = "更新に成功しました！"
            redirect_to post_summary_path(@post_summary.id)
        else
            render :edit
        end
    end

    def destroy
        @post_summary = PostSummary.find(params[:id])
        @post_summary.destroy
        redirect_to root_path
    end

    private

    def post_summary_params
        params.require(:post_summary).permit(:headline, :introduction, :title, :category, post_house_attributes: [:link], post_outside_attributes: [:address], post_images_images: [],)
    end

end
