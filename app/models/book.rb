class Book < ActiveRecord::Base
  belongs_to :user
  validates :name,presence: true
  has_many :requests

  def unanswered_requests
    self.requests.where(:status => 0)
  end
  def self.search query
    books =[]
    if query
      query =query.split
      query.each do |word|
        books=books|where("name like ?", "%#{word}%")
      end
      return books
    else
      all
    end
  end
end
