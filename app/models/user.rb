class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :books, dependent: :destroy
  has_many :requests
end
