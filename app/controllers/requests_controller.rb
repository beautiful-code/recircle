class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_request, only: [:create]


  def create
    #if (Book.find(params[:request][:book_id]).status == false)
      #flash[:danger] = "Book Not Available"
      #redirect_to root_url
      #return
    #end
    @request = current_user.requests.build(request_params)
    @request.owner = @request.book.owner
    if @request.save
      flash[:success] = "Successfully Requested Book"
    end

    redirect_to request.referer
  end

  def index
    @requests_to_my_books_hash = current_user.requests_to_my_books
    @pending_requests = current_user.pending_requests
  end

  def accept
    @request=Request.find(params[:id])
    if current_user.owns? (@request.book)
      @request.update_attributes(status: Request::ACCEPTED_CODE)
      @request.book.update_attributes(user_id: @request.requester.id)
      flash[:success] = 'Request accepted'
    else
      flash[:danger] = 'You cannot update this book'
    end

    redirect_to request.referer
  end

  def decline
    @request=Request.find(params[:id])
    if current_user.owns? (@request.book)
      @request.update_attributes(status: Request::DECLINED_CODE)
      flash[:success] = 'Request declined'
    else
      flash[:danger] = 'You cannot update this book'
    end

    redirect_to request.referer
  end
  def cancel
    @request=Request.find(params[:id])
    if current_user.requester?(@request)
      @request.update_attributes(status: Request::CANCELED_CODE)
      flash[:success] = 'Request canceled'
    else
      flash[:warning] = 'You cannot cancel this book'
    end

    redirect_to request.referer
  end

  private
  def request_params
    params.require(:request).permit(:book_id)
  end

  def validate_request
    book = Book.where(id: params[:request][:book_id]).first
    unless book
      flash[:danger] = 'Book no found'
      redirect_to root_path
    else
      if current_user.owns?(book)
        flash[:danger] ="You cannot request your own book"
        redirect_to root_url
      elsif current_user.has_an_open_request?(book)
        flash[:danger] ="You cannot request again"
        redirect_to root_url
      end
    end
  end

end
