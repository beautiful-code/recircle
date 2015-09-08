module BookHelper
  def request_button_class
    if @book.status == true
      "btn btn-primary"
    else
      "btn btn-primary disabled"
    end
  end
  def validate_user
    if current_user!=@book.user && @book.requests.find_by(user_id:current_user,status:Request::PENDING_CODE) == nil
      true
    else
      false
    end
  end
end
