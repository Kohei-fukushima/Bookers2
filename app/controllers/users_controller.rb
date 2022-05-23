class UsersController < ApplicationController
    before_action :check_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to user_path(@user.id), notice: 'You have created profile successfully.'
   else
     render :edit
   end
  end

  def index
    @users = User.all
    @book = Book.new
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
