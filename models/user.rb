require_relative "../config/database"

class User
  
  def self.find(id)
    result = DB.exec_params(
      "SELECT * FROM users WHERE id = $1",
      [id]
    )

    result.first
  end

  def self.find_by_email(email)
    result = DB.exec_params(
      "SELECT * FROM users WHERE email = $1",
      [email]
    )

    result.first
  end

  def self.create(name, email, password)
    result = DB.exec_params(
      "INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id",
      [name, email, password]
    )

    result[0]["id"]
  end


end