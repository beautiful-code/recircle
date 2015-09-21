class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_request, only: [:create]


  def create
    @request = current_user.requests.build(request_params)
    @request.owner = @request.book.owner
    if @request.save
      flash[:success] = "Successfully Requested Book"
    end
    Event.create_request_event(@request,Event::NEW_REQUEST)

    redirect_to request.referer
  end

  def index
    @requests_to_my_books_hash = current_user.requests_to_my_books
    @pending_requests = current_user.pending_requests
  end

  def accept
    @request=Request.find(params[:id])
    if current_user.owns? (@request.book)
      @request.accept
      flash[:success] = 'Request accepted'
    else
      flash[:danger] = 'You cannot update this book'
    end

    redirect_to user_requests_path(current_user)
  end

  def decline
    @request=Request.find(params[:id])
    if current_user.owns? (@request.book)
      @request.decline
      flash[:success] = 'Request declined'
    else
      flash[:danger] = 'You cannot update this book'
    end

    redirect_to request.referer
  end

  def cancel
    @request=Request.find(params[:id])
    if current_user.requester?(@request)
      @request.cancel
      flash[:success] = 'Request canceled'
    else
      flash[:warning] = 'You cannot cancel this book'
    end

    redirect_to request.referer
  end

  private
  def request_params
    params.require(:request).permit(:book_id,:message,:request_type)
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
      elsif book.lock?
        flash[:danger] ="You cannot request locked book"
        redirect_to root_url
      elsif current_user.has_an_open_request?(book)
        flash[:danger] ="You cannot request again"
        redirect_to root_url
      end
    end
  end

end
