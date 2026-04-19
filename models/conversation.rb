class Conversation

  def self.list(user_id)
    result = DB.exec_params(
      "SELECT id, title FROM conversations WHERE user_id = $1 ORDER BY id DESC",
      [user_id]
    )

    result.map do |c|
      {
        id: c["id"],
        title: c["title"]
      }
    end
  end

end