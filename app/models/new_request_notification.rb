class NewRequestNotification < Notification
  def message
      "New Request for book #{link_to self.book.name,user_book_path(self.book.owner,self.book)} ".html_safe
  end
end
