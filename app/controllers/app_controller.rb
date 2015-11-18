class AppController < ApplicationController
  before_action :authenticate_user!,except: :index
  def index
    if current_user
      if current_user.new?
        render 'start'
      else
        @books =Book.all
        render 'home'
      end
    else
      @total_books_count = Book.count
      @last_six_books = Book.last(6)
      render 'index'
    end
  end

  def search
    @books = Book.search (params[:search])
    render 'home'
  end
end
