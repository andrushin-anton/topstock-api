class Api::V1::Stats < ApplicationRecord

  # Scores
  EXCELLENT = 4
  VERY_GOOD = 3
  GOOD = 2
  MARGINAL = 1
  BAD = 0

  def self.find_by_ticker(ticker)
    stats = Api::V1::Stats.where('ticker = ?', ticker).first
    if stats.nil?
      stats = Api::V1::Stats.new
      stats.ticker = ticker
    end
    return stats
  end

  # Finds stats for a given company and calculates fundamentals
  def fundamental(ticker)
    stats = Api::V1::Stats.find_by_ticker(ticker)

    # filter #1 Return on Equity
    result_filter_roe = filter_fundamental_roe(stats.roe)
    # filter #2 Net income last years
    result_filter_net_income = filter_fundamental_net_income(stats.netincome)


  end

  # Finds stats for a given company and calculates economic moat
  def moat(ticker)

  end

  # Finds current stock price and calculates the real price
  def real_price(ticker)

  end


  # Fundamental filters
  # ROE
  def filter_fundamental_roe(roe_data)
    data = check_if_data_exists(roe_data)
    if data == false
      return Api::V1::Stats::BAD
    end

    # get the latest ROE value and convert it to %
    roe_latest = (data[0]['value'] * 100).round

    if roe_latest >= 30
      return Api::V1::Stats::EXCELLENT
    end

    if roe_latest < 30 && roe_latest >= 20
      return Api::V1::Stats::VERY_GOOD
    end

    if roe_latest > 15 && roe_latest <= 20
      return Api::V1::Stats::GOOD
    end

    if roe_latest > 12 && roe_latest <= 15
      return Api::V1::Stats::MARGINAL
    end

    return Api::V1::Stats::BAD
  end

  # NET INCOME
  def filter_fundamental_netincome(netincome)
    data = check_if_data_exists(netincome)
    if data == false
      return Api::V1::Stats::BAD
    end

    if (data.count >= 3)
      score = has_grown(data, 3)
    elsif (data.count >= 2)
      score = has_grown(data, 2)
    elsif (data.count >= 1)
      score = has_grown(data, 1)
    end

    # The more times Net Income has grown in the past 3 years, the better.
    case score
      when 2
        # Rate Excellent if it has grown 2 times
        return Api::V1::Stats::EXCELLENT
      when 1
        # Very Good if it has grown 1
        return Api::V1::Stats::VERY_GOOD
      when 0
        # Marginal otherwise
        return Api::V1::Stats::MARGINAL
    end

    # Otherwise BAD
    return Api::V1::Stats::BAD

  end




  # Helper method
  def has_grown(data, times)
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

  def check_if_data_exists(data)
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
