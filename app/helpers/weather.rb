module Weather

  def start_wunder
    env_config = YAML.load_file(APP_ROOT.join('config', 'wunderground.yaml'))

    env_config.each do |key, value|
      ENV[key] = value
    end

    Wunderground.new ENV["api_key"]
  end

  def self.get_sunset_time
    state = 'CA'
    city = 'San_Francisco'

    astronomy = Weather.start_wunder.astronomy_for(state, city)
    sunset_time = astronomy['sun_phase']['sunset']
    today = Format.time(sunset_time['hour'], sunset_time['minute'])
    save_to_db(Sunset.new, {sunset_time: today} )
  end

  def self.get_conditions
    state = 'CA'
    city = 'San_Francisco'

    conditions = Weather.start_wunder.conditions_for(state, city)
    c = conditions['current_observation']
    params = { weather:           c['weather'], 
               temp_f:            c['temp_f'], 
               wind_string:       c['wind_string'], 
               wind_dir:          c['wind_dir'], 
               visibility_mi:     c['visibility_mi'], 
               precip_1hr_string: c['precip_1hr_string'] }

    save_to_db(Condition.new, params)
  end

  def save_to_db(type, params)
    t = type(params)
    t.save
    p t
  end

end

# print 'weather: ', conditions['current_observation']['weather'], "\n"
# print 'temp_f: ', conditions['current_observation']['temp_f'], "\n"
# print 'wind_string: ', conditions['current_observation']['wind_string'], "\n"
# print 'wind_dir: ', conditions['current_observation']['wind_dir'], "\n"
# print 'visibility_mi: ', conditions['current_observation']['visibility_mi'], "\n"
# print 'precip_1hr_string: ', conditions['current_observation']['precip_1hr_string'], "\n"


# Weather.get_sunset_time #=> "4:58 PM"
