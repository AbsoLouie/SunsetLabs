enable :sessions
include Twilioer

get '/' do
  if session[:id]
    @user = User.find(session[:id])
    erb :user_homepage
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

post "/users/text_messages" do

  client = Twilioer.start_client
  client.account.messages.create(
    :from => "17146602442",
    :to => User.find_by_id(session[:id]).phone_number,
    :body => params[:text]
    )
  redirect '/'
end

post "/users/text_messages/sunset" do

wunder = Wunderground.new('4e49c02d3a1533bd')
state = 'CA'
city = 'San_Francisco'
astronomy = wunder.astronomy_for(state, city)


  client = Twilioer.start_client
  client.account.messages.create(
    :from => "17146602442",
    :to => User.find_by_id(session[:id]).phone_number,
    :body => astronomy['sun_phase']['sunset']
    )
  redirect '/'
end

#### TODO

# post '/users/:id/edit' do
# end

#Logout display some pages
#flash messages for incorrect passwords, etc..
#cleanup verify
