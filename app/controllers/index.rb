enable :sessions
include Twilioer
include Weather
include Format
include AddonText

get '/' do

  @sunset_header = Weather.sunset_header
  @fullmoon_header = Weather.fullmoon_header

  if session[:id]
    @user = User.find(session[:id])
    erb :user_homepage
  else
    erb :login
  end
end

get '/users/new' do
  @sunset_header = Weather.sunset_header

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

  message = AddonText.happy + ' Tonight\'s sunset is at ' + sunset_time

  client = Twilioer.start_client
  client.account.messages.create(
    :from => "17146602442",
    :to => User.find_by_id(session[:id]).phone_number,
    :body => message
    )

  redirect '/'
end

post "/users/text_messages/fullmoon" do
  if Fullmoon.fullmoon
    message = AddonText.moon_text + 'Tonight, there will be a shining full moon.'

    client = Twilioer.start_client
    client.account.messages.create(
      :from => "17146602442",
      :to => User.find_by_id(session[:id]).phone_number,
      :body => message
      )
    redirect '/'
  else
    redirect '/'

  end
end

get '/secret/sun' do


  sunset_time = Sunset.last.sunset_time

  user_phone_numbers = ['864-764-5317', '907-717-6929', '412-378-0189', '714-743-2022']

  user_phone_numbers.each do |phone_number|

    message = AddonText.happy + ' Tonight\'s sunset is at ' + sunset_time

    client = Twilioer.start_client
    client.account.messages.create(
      :from => "17146602442",
      :to => phone_number,
      :body => message
      )
  end


  redirect '/'
end

get '/secret/moon' do

  moon_message = "There isn't a full moon tonight."
  moon_message = "There is a full moon tonight." if Fullmoon.last.fullmoon

  user_phone_numbers = ['864-764-5317', '907-717-6929', '412-378-0189', '714-743-2022']

  user_phone_numbers.each do |phone_number|

    message = AddonText.moon_text + ' ' + moon_message

    client = Twilioer.start_client
    client.account.messages.create(
      :from => "17146602442",
      :to => phone_number,
      :body => message
      )
  end


  redirect '/'
end
