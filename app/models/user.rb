class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :books, dependent: :destroy
  has_many :requests

  # Build a hash of book to unanswered requests
  def open_requests
    open_request_hash = Hash.new
    self.books.each{|book| open_request_hash[book]=book.unanswered_requests}
    return open_request_hash
  end
end
