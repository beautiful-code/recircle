class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
    @book = Book.new
    @book.image=""
  end

  def pickup_time
    if @book=current_user.books.find(params[:book_id])
    else
      redirect_to root_path
    end
  end

  def create

    if(params["isbn_number"])
      book_response = JSON.parse(get_book_details())
      if book_response["totalItems"] == 0
        flash[:danger] ="Book for given isbn not found"
        redirect_to request.referer
        return
      else
        book=book_response["items"][0]["volumeInfo"]
        if book["imageLinks"]
          @book=current_user.books.build(name:book["title"],image:book["imageLinks"]["thumbnail"],isbn:params["isbn_number"],author:book["authors"][0])
        else
          @book=current_user.books.build(name:book["title"],isbn:params["isbn_number"],author:book["authors"][0])
        end
      end
    else
      @book = current_user.books.build(book_params)
    end

    if @book.save
      redirect_to user_shared_books_path(current_user)
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
    if current_user.borrowed?(@book)
      @book.update_attributes(borrower_id:nil)
      flash[:success] = "Successfully given back"
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
  def get_book_details
    RestClient.get("https://www.googleapis.com/books/v1/volumes?q=+isbn:#{params["isbn_number"]}&key=AIzaSyCiQ_Ia7tUXRw18aDT9kiq5bjbmCYYaVzw")
  end
end
