class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.unread_notifications

    respond_to do |format|
      format.js
      format.html
    end
  end

  def read
    @notification = Notification.find(params[:id])
    @notification.read

    redirect_to request.referer
  end
end
