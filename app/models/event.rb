class Event < ActiveRecord::Base
  after_commit :create_request_notification,on: :create
  serialize :event_data, Hash
  validates :event_type, presence:true
  validates :event_data, presence:true

  #EVENT TYPES
  NEW_REQUEST = "new_request"
  REQUEST_ACCEPTED = "request_accepted"
  REQUEST_DECLINED = "request_declined"
  GIVE_BACK = "give_back"

  def self.create_request_event(request,type)
    event_data = {
      book_id: request.book_id,
      owner_id: request.owner_id,
      requester_id: request.user_id
    }
    Event.create(event_type:type,event_data:event_data)
  end

  private

  def create_request_notification
    if self.event_type == REQUEST_ACCEPTED
      Notification.create(user_id:self.event_data[:requester_id],book_id:self.event_data[:book_id],type:Notification::ACCEPTED)
    elsif self.event_type == REQUEST_DECLINED
      Notification.create(user_id:self.event_data[:requester_id],book_id:self.event_data[:book_id],type:Notification::DECLINED)
    elsif self.event_type == NEW_REQUEST
      Notification.create(user_id:self.event_data[:owner_id],book_id:self.event_data[:book_id],type:Notification::NEW)
    end
  end
  handle_asynchronously :create_request_notification
end
