class Request < ActiveRecord::Base
  belongs_to :requester, class_name: 'User', foreign_key: :user_id
  belongs_to :owner, class_name: 'User',foreign_key: :owner_id
  belongs_to :book
  self.inheritance_column =:request_type


  #request status codes
  PENDING_CODE = 0
  ACCEPTED_CODE = 1
  DECLINED_CODE = 2
  CANCELED_CODE = 3

  #request_type codes
  GIVE_AWAY = "GiveAwayRequest"
  LEND = "LendRequest"

  def self.request_types
    %w(GiveAwayRequest LendRequest)
  end

  scope :give_away_requests,-> {where(request_type: GIVE_AWAY)}
  scope :lend_requests , -> {where(request_type: LEND)}

  def cancel
    self.update_attributes(status: Request::CANCELED_CODE)
  end
  def decline
    self.update_attributes(status: Request::DECLINED_CODE)
    Event.create_request_event(self,Event::REQUEST_DECLINED)
  end
end
