class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def shared_books
    @books = current_user.books
  end

  def address
  end

  def update_address
    current_user.update_attributes(user_params)
    redirect_to root_path
  end

  def account
    @user = current_user
  end
  private
  def user_params
    params.require(:user).permit(:company,:landmark,:area,:fulladdress)
  end
end
