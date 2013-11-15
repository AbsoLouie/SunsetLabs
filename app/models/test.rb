require 'wunderground'

wunder = Wunderground.new('4e49c02d3a1533bd')

state = 'CA'
city = 'San_Francisco'

conditions = wunder.conditions_for(state, city)

# "visibility_mi": "10.0"


# conditions['current_observation'].each do |k, v|
#   puts k
# end


# weather: Mostly Cloudy
# temp_f: 55.7
# wind_string: Calm
# wind_dir: North
# visibility_mi: 9.0
# precip_1hr_string: 0.00 in ( 0 mm)


# p astronomy['sun_phase']['sunrise']
# p astronomy['sun_phase']['sunset']

# {"hour"=>"6", "minute"=>"48"}
# {"hour"=>"16", "minute"=>"59"}


# puts "Sunphase in San Francisco"
# puts "Sunrise: " + to_english( {"hour"=>"6", "minute"=>"48"} )
# puts "Sunset: " + to_english( {"hour"=>"16", "minute"=>"59"} )
