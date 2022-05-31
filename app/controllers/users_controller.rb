class UsersController < ApplicationController
    before_action :check_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
     render :edit
    else
     redirect_to user_path(current_user.id)
    end
  end

  def update
   @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to user_path(@user.id), notice: 'You have created profile successfully.'
   else
    @books = Book.all
     render :edit
   end
  end

  def index
    @users = User.where.not(id: current_user.id)
    @book = Book.new
    @user = current_user
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
     user = User.find(params[:id])
    @users = user.followers
  end

   private

  def user_params
      params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def check_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
    redirect_to user_path(current_user.id)
    end
  end

end
