class PostSummariesController < ApplicationController
    before_action :exist_item?, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
            # ?=category_id=..がなくかつユーザーがサインインしていない時
        if params[:category].blank? && !user_signed_in?
            @post_summaries = PostSummary.all
        else
            # ?=category_id=..がなくかつユーザーがサインインしている時
            if params[:category].blank? && user_signed_in?
                @post_summaries = PostSummary.where(user_id: current_user.id)
            else
                # ?=category_id=が指定されている時
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
        tag_list = params[:post_summary][:tag_name].delete(' ').delete('　').split(',')
        if post_summary.save
            post_summary.save_post_summaries(tag_list)
            flash[:notice] = "投稿できました！！"
            redirect_to post_summary_path(post_summary.id)
        else
            render :new
        end
    end

    def show
        @post_summary = PostSummary.find(params[:id])
        @user = @post_summary.user
        @review = Review.new
        @reviews = @post_summary.reviews.includes(:user)
    end

    def edit
        @post_summary = PostSummary.find(params[:id])
        @tag_list = @post_summary.tags.pluck(:tag_name).join(',')
        if @post_summary.user == current_user
            render :edit
        else
            redirect_to root_path
        end
    end

    def update
        post_summary = PostSummary.find(params[:id])
        tag_list = params[:post_summary][:tag_name].delete(' ').delete('　').split(',')
        if post_summary.update(post_summary_params)
            post_summary.save_post_summaries(tag_list)
            flash[:notice] = "更新に成功しました！"
            redirect_to post_summary_path(post_summary.id)
        else
            render :edit
        end
    end

    def destroy
        post_summary = PostSummary.find(params[:id])
        if post_summary.user = current_user
            post_summary.destroy
            redirect_to root_path
        else
            post_summary = PostSummary.find(params[:id])
            render :show
        end
    end

    private

    def post_summary_params
        params.require(:post_summary).permit(:headline, :introduction, :title, :category, post_house_attributes: [:link], post_outside_attributes: [:address], post_images_images: [],)
    end

    def exist_item?
        unless @post_summaries = PostSummary.find_by(id: params[:id])
          redirect_to root_path
        end
    end

    def authenticate_user!
        unless user_signed_in?
          #サインインしていないユーザーはログインページが表示される
          redirect_to  new_user_session_path
        end
    end

end
