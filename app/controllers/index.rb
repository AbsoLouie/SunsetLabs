enable :sessions
include Twilioer
include Weather
include Format
include AddonText

get '/' do
  if session[:id]
    @user = User.find(session[:id])
    erb :user_homepage
  else
    erb :login
  end
end

get '/users/new' do
  erb :signup
end

post '/users' do
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

  sunset_time = Sunset.last.sunset_time

  # p HappyThoughts.happy

  p AddonText.happy + ' Tonight\'s sunset is at ' + sunset_time

  # client = Twilioer.start_client
  # client.account.messages.create(
  #   :from => "17146602442",
  #   :to => User.find_by_id(session[:id]).phone_number,
  #   :body => HappyThoughts.happy +  sunset_time
  #   )

  redirect '/'
end

#### TODO

# post '/users/:id/edit' do
# end

#Logout display some pages
#flash messages for incorrect passwords, etc..
#cleanup verify
