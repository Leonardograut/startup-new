class Message

  def self.save(user_id, role, content)
    begin
     DB.exec_params(
      "INSERT INTO messages (user_id, role, content) VALUES ($1, $2, $3)",
      [user_id, role, content]
     )
     puts "SALVO COM SUCESSO"
     rescue => e
     puts "ERRO:", e.message
   end
  end

  def self.history(user_id)
    result = DB.exec_params(
      "SELECT role, content FROM messages WHERE user_id = $1 ORDER BY id ASC",
      [user_id]
    )

    result.map do |row|
      {
        role: row["role"],
        content: row["content"]
      }
    end
  end

end