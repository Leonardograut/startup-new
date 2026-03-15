require "sinatra"
enable :sessions

post "/register" do

  name = params[:name]
  email = params[:email]
  password = params[:password]

  user_id = User.create(name, email, password)

  session[:user_id] = user_id

  redirect "/"

end

post "/login" do

  user = User.find_by_email(params[:email])

  if user && user["password"] == params[:password]

    session[:user_id] = user["id"]

    redirect "/"

  else

    session[:error] = "Login inválido"
    redirect "/login"

  end

end

get "/logout" do
  session.clear
  redirect "/"
end