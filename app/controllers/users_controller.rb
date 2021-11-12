class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def withdraw
    @user = current_user
    @user.update(status: false)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
  params.require(:user).permit(:user_name, :profile_image, :email)
  end

end
