class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :withdraw, :unsubscribe]

  def show
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '更新に成功しました'
      redirect_to user_path(@user.id)
    else
      flash[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def unsubscribe; end

  def withdraw
    @user = User.find(params[:id])
    @user.update(status: false)
    reset_session
    flash[:notice] = '退会処理を実行いたしました'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :profile_image, :email)
  end

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = 'ログインか新規登録してください'
      redirect_to new_user_session_path
    end
  end


  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = '他のユーザーの情報は確認できません'
      redirect_to user_path(current_user)
    end
  end
end
