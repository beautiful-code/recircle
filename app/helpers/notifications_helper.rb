module NotificationsHelper
  def message(notification)
    if notification.type == Notification::NEW
      "New Request for book #{link_to notification.book.name,user_book_path(notification.book.owner,notification.book)} ".html_safe
    else
      "Request for book #{link_to notification.book.name,user_book_path(notification.book.owner,notification.book)} #{notification.type[7,8]}".html_safe
    end
  end
end
