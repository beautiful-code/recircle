class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to library_user_path(current_user)
    else
      render "new"
    end
  end

  def edit
    @book = Book.find(params[:id])
    if !current_user.owns?(@book)
      flash[:danger] = "You cannot update this book"
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:user_id])
    @book = @user.books.find(params[:id])
  end

  def update
    @book = current_user.books.find(params[:id])
    unless @book
      flash[:danger] = "You cannot update this book"
      redirect_to root_path
    else
      @book.update_attributes(book_params)
      redirect_to [current_user, @book]
    end
  end

  private
  def book_params
    params.require(:book).permit(:name,:image,:user_id)
  end
end
