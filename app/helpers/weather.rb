module Weather

  def start_wunder
    # env_config = YAML.load_file(APP_ROOT.join('config', 'wunderground.yaml'))

    # env_config.each do |key, value|
    #   ENV[key] = value
    # end

    Wunderground.new ENV["api_key"]
  end

  def self.get_sunset_time
    state = 'CA'
    city = 'San_Francisco'

    astronomy = Weather.start_wunder.astronomy_for(state, city)
    sunset_time = astronomy['sun_phase']['sunset']

    today = Format.time(sunset_time['hour'], sunset_time['minute'])
    save_to_db(:sunset, {sunset_time: today} )
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

    save_to_db(:conditions, params)
    # Condition.create(params)
  end

  def self.visibility_rating  # TODO: rename usages
    c = Condition.last
    points  = 0
    points += 1 if c.weather                     == 'Calm'
    points += 1 if c.temp_f.to_i                 >= 60
    points += 1 if c.wind_string                 == 'Calm'
    points += 1 if c.visibility_mi.to_i          >= 8
    points += 1 if c.visibility_mi.to_i          >= 10
    points += 1 if c.visibility_mi.to_i          >= 12
    points -= 1 if c.precip_1hr_string.to_f      >= 0.01
    points -= 3 if c.precip_1hr_string.to_f      >= 0.05
    return 'Poor'      if points <  2
    return 'Decent'    if points == 2
    return 'Good'      if points >= 3
    return 'Great'     if points == 5
    return 'Best Ever' if points == 6
  end


  def self.sunset_header
    time = Sunset.last.sunset_time
    quality = Weather.visibility_rating

    tense1, tense2 = 'is', 'will be'
    tense1, tense2 = 'was', 'was' if Time.now.to_s < latest.created_at.to_s

    "Today's sunset #{tense1} at #{latest.sunset_time}, and it #{tense2} <span>#{quality}</span>."
  end


  def save_to_db(type, params)
    Sunset.create(params) if type == :sunset
    Condition.create(params) if type == :conditions
    Fullmoon.create(params) if type == :fullmoon 
  end

  ###############################################################
  #############Fullmoon Functionality############################
  ###############################################################

  def self.get_fullmoon_today  # TODO: call
    state = 'CA'
    city = 'San_Francisco'
    astronomy = Weather.start_wunder.astronomy_for(state, city)
    percentIlluminated = astronomy['moon_phase']['percentIlluminated']
    fullmoon = percentIlluminated.to_i > 97
    save_to_db(:fullmoon, {fullmoon: fullmoon} )
    
  end

  def self.fullmoon_header
    day = Fullmoon.last.created_at.to_s[0..9]
    quality = Weather.visibility_rating
    
    if Fullmoon.last.fullmoon
      "Ladies and Gentlemen, there's a full moon tonight with <span>#{quality}</span> visibility."
    else 
      "The last full moon was on #{day} and had a <span>#{quality}</span> visibility."
    end
  end

end

