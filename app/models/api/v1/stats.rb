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


  end

  # Finds stats for a given company and calculates economic moat
  def moat(ticker)

  end

  # Finds current stock price and calculates the real price
  def real_price(ticker)

  end


  # Fundamental filters
  def filter_fundamental_roe(roe_data)
    data_array = JSON.parse(roe_data)
    # if no roe data - score BAD
    unless data_array.any?
      return Api::V1::Stats::BAD
    end

    # if value is null
    if data_array[0]['value'].nil?
      return Api::V1::Stats::BAD
    end

    # get the latest ROE value and convert it to %
    roe_latest = (data_array[0]['value'] * 100).round

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

end
