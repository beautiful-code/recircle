class Book < ActiveRecord::Base
  belongs_to :user
  validates :name,presence: true
  has_many :requests
end
