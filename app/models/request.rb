class Request < ActiveRecord::Base
  belongs_to :requester, class_name: 'User', foreign_key: :user_id
  belongs_to :book

  PENDING_CODE = 0
  ACCEPTED_CODE = 1
  DECLINED_CODE = 2

end
