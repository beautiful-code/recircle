class AppController < ApplicationController
  before_action :authenticate_user!
  def index
    @books = Book.all
  end
  def search
    @books = Book.search (params[:search])
    render 'index'
  end
end
