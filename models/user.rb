class User < ActiveRecord::Base
  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  def self.find_by_email(email)
    find_by(email: email)
  end
end
