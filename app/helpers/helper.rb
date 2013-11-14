module Twilioer
  
  def start_client
    env_config = YAML.load_file(APP_ROOT.join('config', 'twilio.yaml'))

    env_config.each do |key, value|
      ENV[key] = value
    end

    Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
  end

end


# Twillioer.send_message()
