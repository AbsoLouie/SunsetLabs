require 'twitter'

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  @user = TwitterUser.create(:name => params[:twitter][:username])
  @tweets = Twitter.user_timeline(params[:twitter][:username])
  @view_tweets = @tweets[0..10]
  @view_tweets.each do |tweet|
  Tweet.create(:post => tweet.text, :twitter_user_id => @user.id)
  end
  erb :index
end



