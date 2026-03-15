class Message

  def self.save(user_id, role, content)
    stmt = DB.prepare("INSERT INTO messages (user_id, role, content) VALUES (?,?,?)")
    stmt.execute(user_id, role, content)
  end

  def self.history(user_id)

    stmt = DB.prepare("
      SELECT role, content
      FROM messages
      WHERE user_id = ?
      ORDER BY id ASC
    ")

    result = stmt.execute(user_id)

    result.map do |row|
      {
        role: row["role"],
        content: row["content"]
      }
    end

  end

end