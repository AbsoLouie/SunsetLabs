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
    save_to_db(today)
  end

  def save_to_db(time)
    Sunset.create sunset_time: time
  end

end

# Weather.get_sunset_time #=> "4:58 PM"