class PostSummariesController < ApplicationController
  before_action :exist_item?, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show like]

  def index
    if params[:category].blank?
      if user_signed_in?
        if params[:search_flag] == 'like'
          all_ranks = PostSummary.includes(:favorites).sort { |a, b| b.favorites.size <=> a.favorites.size }
          @post_summaries = Kaminari.paginate_array(all_ranks).page(params[:page]).per(4)
        elsif params[:search_flag] == 'updated'
          @post_summaries = PostSummary.page(params[:page]).per(4).order(created_at: :desc)
        else
          @post_summaries = PostSummary.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(4)
        end
      elsif params[:search_flag] == 'like'
        all_ranks = PostSummary.includes(:favorites).sort { |a, b| b.favorites.size <=> a.favorites.size }
        @post_summaries = Kaminari.paginate_array(all_ranks).page(params[:page]).per(4)
      else
        @post_summaries = PostSummary.page(params[:page]).per(4).order(created_at: :desc)
      end
    else
      @category = params[:category]
      if params[:search_flag] == 'like'
        all_ranks = PostSummary.where(category: params[:category]).includes(:favorites).sort { |a, b| b.favorites.size <=> a.favorites.size }
        @post_summaries = Kaminari.paginate_array(all_ranks).page(params[:page]).per(4)
      elsif params[:search_flag] == 'updated'
        @post_summaries = PostSummary.page(params[:page]).per(4).order(created_at: :desc)
      else
        @post_summaries = PostSummary.where(category: params[:category]).order(created_at: :desc).page(params[:page]).per(4)
      end
    end
  end

  def new; end

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
    tag_list = params[:post_summary][:tag_name].delete(' ').delete('　').split('#')
    tag_list.delete('')
    if post_summary.save
      post_summary.save_tag(tag_list)
      flash[:notice] = '投稿できました！！'
      redirect_to post_summary_path(post_summary.id)
    else
      flash[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def show
    @post_summary = PostSummary.find(params[:id])
    @user = @post_summary.user
    @tags = @post_summary.tags
    @review = Review.new
    @reviews = @post_summary.reviews.includes(:user)
  end

  def edit
    @post_summary = PostSummary.find(params[:id])
    @tag_list = @post_summary.tags.pluck(:tag_name).join('#')
    if @post_summary.user == current_user
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @post_summary = PostSummary.find(params[:id])
    @post_summary.user = current_user
    tag_list = params[:post_summary][:tag_name].delete(' ').delete('　').split('#')
    tag_list.delete('')
    if @post_summary.update(post_summary_params)
      @post_summary.save_tag(tag_list)
      flash[:notice] = '更新に成功しました！'
      redirect_to post_summary_path(@post_summary.id)
    else
      flash[:alert] = '更新に失敗しました'
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
    params.require(:post_summary).permit(:headline, :introduction, :title, :category, post_house_attributes: [:link],
                                                                                      post_outside_attributes: [:address], post_images_images: [])
  end

  def exist_item?
    redirect_to root_path unless @post_summaries = PostSummary.find_by(id: params[:id])
  end

  def authenticate_user!
    unless user_signed_in?
      # サインインしていないユーザーはログインページが表示される
      flash[:alert] = 'ログインか新規登録してください'
      redirect_to new_user_session_path
    end
  end
end
