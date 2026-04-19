require "sinatra"
require "json"
require "net/http"
require "uri"
require "dotenv/load"

enable :sessions

require_relative "./config/database"

set :bind, "0.0.0.0"
set :port, ENV["PORT"] || 4567


require_relative "./models/user"
require_relative "./models/message"
require_relative "./models/conversation"

require_relative "./controller/page_controller"
require_relative "./controller/auth_controller"
require_relative "./controller/chat_controller"