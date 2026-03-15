require "mysql2"
require "dotenv/load"

DB = Mysql2::Client.new(
  host: ENV["DB_HOST"],
  username: ENV["DB_USER"],
  password: ENV["DB_PASSWORD"],
  database: ENV["DB_NAME"]
)