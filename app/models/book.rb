class Book < ActiveRecord::Base
  belongs_to :user
  validates :name,presence: true
  has_many :requests

  def unanswered_requests
    self.requests.where(:status => 0)
  end
end
