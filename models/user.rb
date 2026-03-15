require_relative "../config/database"

class User

  def self.find(id)
    
    stmt = DB.prepare("SELECT * FROM users WHERE id = ?")
    result = stmt.execute(id)
    
    result.first
  end

  def self.find_by_email(email)
    
    stmt = DB.prepare("SELECT * FROM users WHERE email = ?")
    result = stmt.execute(email)
    
    result.first
  end

  def self.create(name,email,password)
    
    stmt = DB.prepare("INSERT INTO users (name,email,password) VALUES (?,?,?)")
    stmt.execute(name,email,password)
    
    DB.last_id
  end

end