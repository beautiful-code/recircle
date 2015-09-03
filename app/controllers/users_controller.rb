class UsersController < ApplicationController
  before_action :authenticate_user!,except: [:library]

  def show
    @user = User.find(params[:id])
  end

  def library
    @user = User.find(params[:id])
    @books = @user.books
  end

  def account
    @user = current_user
  end
end
