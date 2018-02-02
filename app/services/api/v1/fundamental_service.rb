require_relative './common_service'

class Api::V1::FundamentalService

  # Scores
  EXCELLENT = 4
  VERY_GOOD = 3
  GOOD = 2
  MARGINAL = 1
  BAD = 0

  # Starting point
  def self.calculate(ticker)
    stats = Api::V1::Stats.find_by_ticker(ticker)
    # filter #1 Return on Equity
    result_filter_roe = Api::V1::FundamentalService.filter_fundamental_roe(stats.roe)
    # filter #2 Net income last years
    result_filter_net_income = Api::V1::FundamentalService.filter_fundamental_net_income(stats.netincome)
  end


  # Filters

  # ROE
  def self.filter_fundamental_roe(roe_data)
    data = Api::V1::CommonService.check_if_data_exists(roe_data)
    if data == false
      return Api::V1::FundamentalService::BAD
    end

    # get the latest ROE value and convert it to %
    roe_latest = (data[0]['value'] * 100).round

    if roe_latest >= 30
      return Api::V1::FundamentalService::EXCELLENT
    end

    if roe_latest < 30 && roe_latest >= 20
      return Api::V1::FundamentalService::VERY_GOOD
    end

    if roe_latest > 15 && roe_latest <= 20
      return Api::V1::FundamentalService::GOOD
    end

    if roe_latest > 12 && roe_latest <= 15
      return Api::V1::FundamentalService::MARGINAL
    end

    return Api::V1::FundamentalService::BAD
  end

  # NET INCOME
  def self.filter_fundamental_net_income(netincome)
    data = Api::V1::CommonService.check_if_data_exists(netincome)
    if data == false
      return Api::V1::FundamentalService::BAD
    end

    if (data.count >= 3)
      score = Api::V1::CommonService.has_grown(data, 3)
    elsif (data.count >= 2)
      score = Api::V1::CommonService.has_grown(data, 2)
    elsif (data.count >= 1)
      score = Api::V1::CommonService.has_grown(data, 1)
    end

    # The more times Net Income has grown in the past 3 years, the better.
    case score
      when 2
        # Rate Excellent if it has grown 2 times
        return Api::V1::FundamentalService::EXCELLENT
      when 1
        # Very Good if it has grown 1
        return Api::V1::FundamentalService::VERY_GOOD
      when 0
        # Marginal otherwise
        return Api::V1::FundamentalService::MARGINAL
    end

    # Otherwise BAD
    return Api::V1::FundamentalService::BAD
  end

end