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
  def give_back
    @book = Book.find(params[:book_id])
    if current_user.lent?(@book)
      flash[:success] = "Successfully given back"
      @book.update_attributes(lender_id:nil)
    end
    redirect_to root_path
  end

  def show
    @user = User.find(params[:user_id])
    @book = @user.books.find(params[:id])
    @request = Request.new
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
  def lock
    @book = current_user.books.where(id:params[:book_id]).first
    if @book
      @book.update_attributes(state:"locked")
      flash[:success] = "Book successfully locked"
    end
    redirect_to request.referer
  end
  def unlock
    @book = current_user.books.where(id:params[:book_id]).first
    if @book
      @book.update_attributes(state:"unlocked")
      flash[:success] = "Book successfully unlocked"
    end
    redirect_to request.referer
  end

  private
  def book_params
    params.require(:book).permit(:name,:image,:user_id)
  end
end
