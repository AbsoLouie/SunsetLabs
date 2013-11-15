def texting
  p sunset_time = Sunset.last.sunset_time

  p message = AddonText.happy + ' Tonight\'s sunset is at ' + sunset_time

  p all_users = User.all
  # client = Twilioer.start_client
  # client.account.messages.create(
  #   :from => "17146602442",
  #   :to => User.find_by_id(session[:id]).phone_number,
  #   :body => message
  #   )
end