def texting

  sunset_time = Sunset.last.sunset_time

  message = AddonText.happy + ' Tonight\'s sunset is at ' + sunset_time

  user_phone_numbers = []

  User.all.each do |user|
    user_phone_numbers << user.phone_number
  end

  user_phone_numbers.each do |phone_number|
  client = Twilioer.start_client
  client.account.messages.create(
    :from => "17146602442",
    :to => phone_number,
    :body => message
    )
  end

end

