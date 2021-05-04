class BooksController < ApplicationController

  before_action :authenticate_user!
   before_action :correct_user,only: [:edit]

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @book_comment=BookComment.new

  end

  def show
    @book = Book.new
    @current_book = Book.find(params[:id])
    @user = @current_book.user
    @book_comment = BookComment.new
  end

  def create
    @book = current_user.books.new(book_params)
    @books = Book.all
    @user = current_user
    if @book.save
      redirect_to book_path(@book.id), notice:"create book successfully"
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice:"update book successfully"
    else
      render :edit
    end
  end



  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path, notice: "destroy book successfully"
    else
      render :index
    end
  end



  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def correct_user
      book = Book.find(params[:id])
        @user = book.user
      unless @user.id == current_user.id
        redirect_to books_path
      end
  end



end
