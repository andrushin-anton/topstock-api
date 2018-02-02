class CommonService

  # Helper methods

  def self.has_grown(data, times)
    score = 0
    i = 1
    # set the latest value
    latest_value = data[0]['value']

    while i < times
      if latest_value >= data[i]['value']
        score += 1
      end
      latest_value = data[i]['value']
      i += 1
    end
    return score
  end

  def self.check_if_data_exists(data)
    if data.to_s.empty?
      # It's nil or empty
      return false
    end
    data_array = JSON.parse(data)
    # if no roe data - score BAD
    unless data_array.any?
      return false
    end

    # if value is null
    if data_array[0]['value'].nil?
      return false
    end
    return data_array
  end

end