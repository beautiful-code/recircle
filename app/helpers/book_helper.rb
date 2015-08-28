module BookHelper
  def request_button_class
    if @book.status == true
      "btn btn-primary"
    else
      "btn btn-primary disabled"
    end
  end
end
