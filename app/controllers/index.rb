get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  p params
  User.create(params[:user])
  redirect '/'
end
