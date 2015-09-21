class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  self.inheritance_column =:type

  #NOTIFICATION STATUS
  UNREAD = 0
  READ =1
  #Notification type
  NEW = "NewRequestNotification"
  DECLINED = "RequestDeclinedNotification"
  ACCEPTED = "RequestAcceptedNotification"

  def read
    self.update_attributes(read_status:READ)
  end
  def self.types
    %w(NewRequestNotification RequestDeclinedNotification RequestAcceptedNotification)
  end

end
