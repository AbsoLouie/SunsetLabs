module Format

    def self.time(hour, minute)
    suffix = 'AM'
    if hour.to_i > 11
      suffix = 'PM'
      hour = hour.to_i - 12
    end

    "#{hour}:#{minute} #{suffix}"
  end

end