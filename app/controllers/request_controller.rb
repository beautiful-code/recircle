class RequestController < ApplicationController
  def create
    begin
      if (Book.find(params[:request][:book_id]).status == false)
        flash[:danger] = "Book Not Available"
        redirect_to root_path
        return
      end
    rescue
      flash[:danger] = "Can't Find The Book"
      redirect_to root_path
      return
    end
    @request=current_user.requests.build(request_params)
    if @request.save
      redirect_to mylibrary_url
    else
      redirect_to root_url
    end
  end
  def show
    @books = current_user.books
  end
  def update
    @request=Request.find(params[:id])
    @request.update_attributes(status:1)
    @request.book.update_attributes(status:false)
  end

  private
  def request_params
    params.require(:request).permit(:book_id)
  end
end
