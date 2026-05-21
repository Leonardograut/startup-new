class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy

  def self.list(user_id)
    where(user_id: user_id)
      .order(id: :desc)
      .pluck(:id, :title)
      .map { |id, title| { id: id, title: title } }
  end
end
