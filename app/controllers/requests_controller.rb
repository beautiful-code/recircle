class RequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    if (Book.find(params[:request][:book_id]).status == false)
      flash[:danger] = "Book Not Available"
      redirect_to root_url
      return
    end
    if (Book.find(params[:request][:book_id]).user.id==current_user.id)
      flash[:danger] ="You cannot request your own book"
      redirect_to root_url
      return
    end
    @request=current_user.requests.build(request_params)
    if @request.save
      flash[:success] = "Successfully Requested Book"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def index
    @requests_hash = current_user.open_requests
  end
  def accept
    @request=Request.find(params[:id])
    @request.update_attributes(status:1)
    @request.book.update_attributes(user_id: @request.user.id)
    redirect_to root_url
  end
  def decline
    @request=Request.find(params[:id])
    @request.update_attributes(status:2)
    redirect_to root_url
  end

  private
  def request_params
    params.require(:request).permit(:book_id)
  end
end
