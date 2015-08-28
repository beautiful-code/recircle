class BookController < ApplicationController
  before_action :authenticate_user!
  def new
    @book = Book.new
  end

  def create
    @book =current_user.books.build(book_params)
    if @book.save
      redirect_to mylibrary_url
    else
      render "new"
    end
  end
  def show
    @book = Book.find(params[:id])
    if @book == nil
      redirect_to root_url
    end
  end



  private
  def book_params
    params.require(:book).permit(:name,:image,:user_id)
  end
end
