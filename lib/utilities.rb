class Utilities

  def self.read_remote_csv(url)
    data = []
    CSV.new(open(url), :headers => :first_row).each do |line|
      data << line
    end
    data
  end

  def self.pull_historic_data(stats, item)
    # Wait half of a sec, no rush here
    sleep(0.5)
    # Make an API call
    response = JSON.parse(
        HTTP.basic_auth(
            :user => Rails.application.secrets.intrino_username,
            :pass => Rails.application.secrets.intrino_password
        ).get("https://api.intrinio.com/historical_data?identifier=#{stats.ticker}&frequency=yearly&item=#{item}").body
    )
    # Append data if only exists
    if response.key?('data')
      stats.send(item+'=', response['data'].to_json)
    end
  end

end