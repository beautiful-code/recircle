class Request < ActiveRecord::Base
  belongs_to :requester, class_name: 'User', foreign_key: :user_id
  belongs_to :owner, class_name: 'User',foreign_key: :owner_id
  belongs_to :book

  #request status codes
  PENDING_CODE = 0
  ACCEPTED_CODE = 1
  DECLINED_CODE = 2
  CANCELED_CODE = 3

  #request_type codes
  GIVE_AWAY = 0
  LEND =1

  def accept
    self.update_attributes(status: Request::ACCEPTED_CODE)
    if self.request_type == Request::GIVE_AWAY
      self.book.update_attributes(user_id: self.requester.id)
    else
      self.book.update_attributes(borrower_id: self.requester.id)
    end
  end
end
