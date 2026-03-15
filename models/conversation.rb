class Conversation

  def self.list(user_id)

    stmt = DB.prepare("
      SELECT id,title
      FROM conversations
      WHERE user_id = ?
      ORDER BY id DESC
    ")

    result = stmt.execute(user_id)

    result.map do |c|
      {
        id: c["id"],
        title: c["title"]
      }
    end

  end

end