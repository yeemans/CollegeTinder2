class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }
  
  has_many :friendships, dependent: :destroy  
  has_many :friends, -> { distinct }, through: :friendships
  has_many :accepted_friends, through: :friendships, :foreign_key => :friend_id
  has_many :friend_requests, foreign_key: 'friend_1_id'
  has_many :messages

  def befriend(user)
    self.friends << user 
    user.friends << self
  end

end
