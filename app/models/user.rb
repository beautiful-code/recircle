class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :books, dependent: :destroy
  has_many :requests
  has_many :requests_to_me,class_name: 'Request',foreign_key: :owner_id
  has_many :borrowed_books,class_name: 'Book',foreign_key: :borrower_id

  #Whether user own book or not
  def owns? book
    book.owner == self
  end

  def borrowed? book
    book.borrower == self
  end

  #User is requester or not
  def requester? request
    request.requester == self
  end

  # Build a hash of book to unanswered requests
  def requests_to_my_books
    requests_to_my_books_hash = Hash.new
    self.books.each{|book| requests_to_my_books_hash[book]=book.unanswered_requests}
    requests_to_my_books_hash
  end

  def has_an_open_request? book
    Request.find_by(user_id: self.id, book_id: book.id ,status: Request::PENDING_CODE) !=nil
  end

  def pending_requests
    self.requests.where(status: Request::PENDING_CODE)
  end

  def requests_history
    self.requests.where.not(status:Request::PENDING_CODE).order(created_at: :desc)
  end

  def requests_to_me_history
    self.requests_to_me.where.not(status:Request::PENDING_CODE).order(created_at: :desc)
  end

end
