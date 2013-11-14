enable :sessions

get '/' do
  if session[:id]
    @user = User.find(session[:id])
    erb :settings
  else
    erb :login
  end
end

get '/users/signup' do
  erb :signup
end

post '/users/register' do
  user = User.create(params[:user])
  session[:id] = user.id
  redirect '/'
end

get '/users/verify' do

  redirect "/" unless params[:user]
  user = User.find_by_email(params[:user][:email])

  redirect "/" if user.nil?

  if user.password == params[:user][:password]
    session[:id] = user.id
  end

  redirect "/"
end

get '/users/logout' do
  session.clear
  redirect '/'
end


#### TODO

# post '/users/:id/edit' do
# end

#Logout display some pages
#flash messages for incorrect passwords, etc..
#cleanup verify
