class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications=current_user.unread_notifications
  end
  def read
    @notification = Notification.find(params[:id])
    @notification.read
    redirect_to user_notifications_path
  end
end
