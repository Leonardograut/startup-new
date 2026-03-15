before do
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end

get "/" do
  erb :home
end

get "/chat" do
  erb :index
end

get "/login" do
  erb :login
end

get "/register" do
  erb :register
end