require "pg"
require "dotenv/load"

DB = PG.connect(ENV["DATABASE_URL"])