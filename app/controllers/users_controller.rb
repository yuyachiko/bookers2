class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user,only: [:edit]

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
       redirect_to user_path(@user.id), notice:"update user info successfully"
    else
      render :edit

    end
  end




 private

  def user_params
    params.require(:user).permit(:name,:profile_image_id,:introduction)
  end

  def correct_user
        @user = User.find(params[:id])
        unless @user.id == current_user.id
          redirect_to user_path(current_user.id)
        end
  end
end
