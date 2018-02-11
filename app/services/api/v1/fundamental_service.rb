require_relative './common_service'

class Api::V1::FundamentalService

  # Scores
  EXCELLENT = 4
  VERY_GOOD = 3
  GOOD = 2
  MARGINAL = 1
  BAD = 0

  # Starting point
  def self.calculate(company)
    stats = Api::V1::Stats.find_by_ticker(company.ticker)

    # filter #1 Return on Equity
    result_filter_roe = Api::V1::FundamentalService.filter_fundamental_roe(stats.roe)

    # filter #2 Net income last years
    result_filter_net_income = Api::V1::FundamentalService.filter_fundamental_net_income(stats.netincome)

    # filter #3 Cash flow
    result_filter_cash_flow = Api::V1::FundamentalService.filter_fundamental_cash_flow(stats.freecashflow)

    # filter #4 Profit Margin against industry avg Profit Margin
    result_filter_avg_profit_margin = Api::V1::FundamentalService.filter_fundamental_avg_profit_margin(stats.profitmargin, Api::V1::Industry.find_industry_avg_profit_margin(company.industry))

    # filter #5 Profit Margin against company's avg
    result_filter_profit_margin = Api::V1::FundamentalService.filter_profit_margin(stats.profitmargin)

    # filter #6 Long-term Debt / Net Income
    result_filter_long_debt_to_net_income = Api::V1::FundamentalService.filter_long_debt_to_net_income(stats.longtermdebt, stats.netincome)

    # filter #7 Gross Profit Margin
    result_gross_profit_margin = Api::V1::FundamentalService.filter_gross_profit_margin(stats.grossmargin)

    return Api::V1::FundamentalService.final_score(
               result_filter_roe,
               result_filter_net_income,
               result_filter_cash_flow,
               result_filter_avg_profit_margin,
               result_filter_profit_margin,
               result_filter_long_debt_to_net_income,
               result_gross_profit_margin
    )
  end

  def self.final_score(roe, net_income, cash_flow, avg_profit_margin, profit_margin, debt_to_net_income, gross_profit_margin)
    return ((roe + net_income + cash_flow + avg_profit_margin + profit_margin + debt_to_net_income + gross_profit_margin) / 7.0).round
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

  # CASH FLOW
  def self.filter_fundamental_cash_flow(cash_flow)
    data = Api::V1::CommonService.check_if_data_exists(cash_flow)
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

    # The more times Cash Flow has grown in the past 3 years, the better.
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

  # Profit Margin against industry AVG
  def self.filter_fundamental_avg_profit_margin(company_profit_margin, avg_industry_profit_margin)
    data = Api::V1::CommonService.check_if_data_exists(company_profit_margin)
    if data == false
      return Api::V1::FundamentalService::BAD
    end
    # Convert company_profit_margin to percent
    profit_margin = data[0]['value'] * 100

    # If the company’s current Profit Margin is greater than the company’s average industry Profit Margin, then rate Excellent
    if profit_margin > avg_industry_profit_margin
      return Api::V1::FundamentalService::EXCELLENT
    end

    # if it’s equal, rate Good
    if profit_margin == avg_industry_profit_margin
      return Api::V1::FundamentalService::GOOD
    end

    # Otherwise rate Bad
    return Api::V1::FundamentalService::BAD

  end

  # Profit Margin against company's AVG
  def self.filter_profit_margin(profit_margin)
    data = Api::V1::CommonService.check_if_data_exists(profit_margin)
    if data == false
      return Api::V1::FundamentalService::BAD
    end

    # find out the avg profit margin for the last 3 years
    i = 1
    total = 0
    data.each do |row|
      if i <= 3
        total += row['value']
      end
      i = i + 1
    end

    if i > 3
      denominator = 3
    else
      denominator = data.count
    end

    # AVG company's profit margin in the last 3 years
    avg_profit_margin = total / denominator

    # If the company’s current Profit Margin is greater than the company’s average Profit Margin, then rate Excellent
    if data[0]['value'] > avg_profit_margin
      return Api::V1::FundamentalService::EXCELLENT
    end

    # if it’s equal, rate Good
    if data[0]['value'] == avg_profit_margin
      return Api::V1::FundamentalService::GOOD
    end

    # Otherwise rate Bad
    return Api::V1::FundamentalService::BAD

  end

  # Long-term Debt / Net Income
  def self.filter_long_debt_to_net_income(longtermdebt, netincome)
    debt_data = Api::V1::CommonService.check_if_data_exists(longtermdebt)
    if debt_data == false
      return Api::V1::FundamentalService::BAD
    end

    income_data = Api::V1::CommonService.check_if_data_exists(netincome)
    if income_data == false
      return Api::V1::FundamentalService::BAD
    end

    score = (debt_data[0]['value'].to_f / income_data[0]['value'].to_f).floor

    # If the company’s current Long-term Debt / Net Income is less than 5 then rate Excellent
    if score < 5
      return Api::V1::FundamentalService::EXCELLENT
    end
    # if it’s between 5 and 16 then rate Good
    if score >= 5 && score < 16
      return Api::V1::FundamentalService::GOOD
    end
    # Otherwise rate Bad
    return Api::V1::FundamentalService::BAD
  end

  # Company’s Gross Profit Margin
  def self.filter_gross_profit_margin(grossmargin)
    data = Api::V1::CommonService.check_if_data_exists(grossmargin)
    if data == false
      return Api::V1::FundamentalService::BAD
    end

    current_gross_margin = data[0]['value'].to_f * 100
    # If the company’s Gross Profit Margin is greater than or equal to 40% then rate Excellent
    if current_gross_margin >= 40
      return Api::V1::FundamentalService::EXCELLENT
    end
    # If it’s between 20% and 40% then rate Good
    if current_gross_margin >= 20 and current_gross_margin < 40
      return Api::V1::FundamentalService::GOOD
    end
    # Otherwise rate Bad
    return Api::V1::FundamentalService::BAD
  end

end