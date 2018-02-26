class Utilities

  def self.read_remote_csv(url)
    data = []
    CSV.new(open(url), :headers => :first_row).each do |line|
      data << line
    end
    data
  end

  def self.pull_in_stats(statistics)
    puts 'ROE'
    Utilities::pull_historic_data(statistics, 'roe')
    puts 'NetIncome'
    Utilities::pull_historic_data(statistics, 'netincome')
    puts 'FreeCashFlow'
    Utilities::pull_historic_data(statistics, 'freecashflow')
    puts 'ProfitMargin'
    Utilities::pull_historic_data(statistics, 'profitmargin')
    puts 'LongTermDebt'
    Utilities::pull_historic_data(statistics, 'longtermdebt')
    puts 'GrossMargin'
    Utilities::pull_historic_data(statistics, 'grossmargin')
    puts 'ROA'
    Utilities::pull_historic_data(statistics, 'roa')
    puts 'DepreciationExpense'
    Utilities::pull_historic_data(statistics, 'depreciationexpense')
    puts 'TotalGrossProfit'
    Utilities::pull_historic_data(statistics, 'totalgrossprofit')
    puts 'PriceToEarnings'
    Utilities::pull_historic_data(statistics, 'pricetoearnings')
    puts 'BookValuePerShare'
    Utilities::pull_historic_data(statistics, 'bookvaluepershare')
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