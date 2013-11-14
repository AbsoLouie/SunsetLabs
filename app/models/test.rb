

# wunder = Wunderground.new('4e49c02d3a1533bd')

# state = 'CA'
# city = 'San_Francisco'

# astronomy = wunder.astronomy_for(state, city)


# astronomy['sun_phase']

# p astronomy['sun_phase']['sunrise']
# p astronomy['sun_phase']['sunset']

# {"hour"=>"6", "minute"=>"48"}
# {"hour"=>"16", "minute"=>"59"}


# def to_english(response)
#   suffix = 'AM'
#   if response['hour'].to_i > 11
#     suffix = 'PM'
#     response['hour'] = response['hour'].to_i - 12
#   end

#   "#{response['hour']}:#{response['minute']} #{suffix}"
# end

# puts "Sunphase in San Francisco"
# puts "Sunrise: " + to_english( {"hour"=>"6", "minute"=>"48"} )
# puts "Sunset: " + to_english( {"hour"=>"16", "minute"=>"59"} )
