require 'net/http'

class Utilities



  def self.read_remote_csv(url)
    data = []
    CSV.new(open(url), :headers => :first_row).each do |line|
      data << line
    end
    data
  end



  def self.pull_in_stats(company, statistics, offset)
    puts 'ROE'
    if Utilities::pull_historic_data(statistics, 'roe') == false
      return self.process_error(company, offset)
    end

    puts 'NetIncome'
    if Utilities::pull_historic_data(statistics, 'netincome') == false
      return self.process_error(company, offset)
    end

    puts 'FreeCashFlow'
    if Utilities::pull_historic_data(statistics, 'freecashflow') == false
      return self.process_error(company, offset)
    end

    puts 'ProfitMargin'
    if Utilities::pull_historic_data(statistics, 'profitmargin') == false
      return self.process_error(company, offset)
    end

    puts 'LongTermDebt'
    if Utilities::pull_historic_data(statistics, 'longtermdebt') == false
      return self.process_error(company, offset)
    end

    puts 'GrossMargin'
    if Utilities::pull_historic_data(statistics, 'grossmargin') == false
      return self.process_error(company, offset)
    end

    puts 'ROA'
    if Utilities::pull_historic_data(statistics, 'roa') == false
      return self.process_error(company, offset)
    end

    puts 'DepreciationExpense'
    if Utilities::pull_historic_data(statistics, 'depreciationexpense') == false
      return self.process_error(company, offset)
    end

    puts 'TotalGrossProfit'
    if Utilities::pull_historic_data(statistics, 'totalgrossprofit') == false
      return self.process_error(company, offset)
    end

    puts 'PriceToEarnings'
    if Utilities::pull_historic_data(statistics, 'pricetoearnings') == false
      return self.process_error(company, offset)
    end

    puts 'BookValuePerShare'
    if Utilities::pull_historic_data(statistics, 'bookvaluepershare') == false
      return self.process_error(company, offset)
    end

    # statistics were pulled update the company status
    company.status = Api::V1::Company::STATUS_NEED_CALCULATIONS
    company.save
    # save statistics
    statistics.save
    # up the offset
    offset += 1
    return offset
  end


  def self.process_error(company, offset)
    # need to pull statistics again next time
    company.status = Api::V1::Company::STATUS_NEED_STATS
    company.save
    # keep the current offset
    return offset
  end



  def self.pull_historic_data(stats, item)
    # Wait half of a sec, no rush here
    sleep(1)
    # Make an API call
    uri = URI("https://api.intrinio.com/historical_data?identifier=#{stats.ticker}&frequency=yearly&item=#{item}")
    req = Net::HTTP::Get.new(uri)
    req.basic_auth Rails.application.secrets.intrino_username, Rails.application.secrets.intrino_password

    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
    }

    if res.is_a?(Net::HTTPSuccess)
      response = res.body.gsub 'NaN', '0.0'
      response = response.gsub 'null', '0.0'
      response_body = JSON.parse(response)
      # Append data if'Robert' only exists
      if response_body.key?('data')
        stats.send(item+'=', response_body['data'].to_json)
      end
      return true
    else
      return false
    end
  end

end