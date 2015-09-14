class Book < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  belongs_to :lender, class_name: 'User',foreign_key: :lender_id
  validates :name,presence: true
  has_many :requests

  def unanswered_requests
    self.requests.where(:status => Request::PENDING_CODE)
  end

  def closed_requests
    requests - unanswered_requests
  end
  def lock?
    self.state == "locked"
  end

  def self.search query
    if query
      query = query.split
      books = query.collect do |word|
        Rails.env.production? ? where("name ilike ?", "%#{word}%") : where("name like ?", "%#{word}%")
      end
      books.flatten
    else
      all
    end
  end
end
