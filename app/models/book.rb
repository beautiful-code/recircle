class Book < ActiveRecord::Base
  belongs_to :user
  validates :name,presence: true
  has_many :requests

  def unanswered_requests
    self.requests.where(:status => Request::PENDING_CODE)
  end

  def self.search query
    if query
      query = query.split
      books = query.collect do |word|
        where("name like ?", "%#{word}%")
      end
      books
    else
      all
    end
  end
end
