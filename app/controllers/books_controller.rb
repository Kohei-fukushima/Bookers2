class BooksController < ApplicationController
  before_action :check_user, only: [:edit, :update]
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
      if @book.save
       redirect_to book_path(@book), notice: 'You have created book successfully.'
      else
       render :index
      end

  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
      if @book.update(book_params)
       redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
      else
       render :edit
      end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def check_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end

  end

end
