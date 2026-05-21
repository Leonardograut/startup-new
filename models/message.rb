class Message < ActiveRecord::Base
  belongs_to :user

  validates :role, :content, presence: true

  def self.history(user_id)
    where(user_id: user_id)
      .order(:id)
      .pluck(:role, :content)
      .map { |role, content| { role: role, content: content } }
  end

  def self.create_message(user_id, role, content)
    create(user_id: user_id, role: role, content: content)
  end
end
