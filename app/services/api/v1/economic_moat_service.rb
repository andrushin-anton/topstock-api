class Api::V1::EconomicMoatService

  # Economic moat scores
  VERY_STRONG = 4
  STRONG = 3
  WEAK = 2

  # Starting point
  def self.calculate(company)
    stats = Api::V1::Stats.find_by_ticker(company.ticker)
    # filter #1 Return on Equity above 15 percent (in each of the past 3 years). Give the company 1 point if it passes or 0 points if it doesn’t.
    result_filter_roe = Api::V1::EconomicMoatService.filter_roe(stats.roe)
    # filter #2 Return on Assets is higher than 6 percent in each of the past 3 years. Give the company 1 point if it passes or 0 points if it doesn’t.
    result_filter_roa = Api::V1::EconomicMoatService.filter_roa(stats.roa)
    # filter #3 Depreciation / Gross Profit
    # Give the company 2 points if it passes with 8% or less, 1 point if it is between 8% and 18% and 0 points if it is 18% or higher
    result_filter_dep = Api::V1::EconomicMoatService.filter_dep(stats.depreciationexpense, stats.totalgrossprofit)
    # Return avg result
    return Api::V1::EconomicMoatService.final_score(result_filter_roe, result_filter_roa, result_filter_dep)
  end



  def self.final_score(roe, roa, dep)
    result = roe + roa + dep
    # Very strong
    if result >= Api::V1::EconomicMoatService::VERY_STRONG
      return Api::V1::EconomicMoatService::VERY_STRONG
    end
    # Strong
    if result >= Api::V1::EconomicMoatService::STRONG
      return Api::V1::EconomicMoatService::STRONG
    end
    # Otherwise WEAK
    return Api::V1::EconomicMoatService::WEAK
  end



  def self.filter_roe(roe_input)
    # check if data exists
    data = Api::V1::CommonService.check_if_data_exists(roe_input)
    if data == false
      return 0
    end

    score = 0
    iterator = 0
    # iterate over the last 3 years
    data.each do |roe|
      if ((roe['value'] * 100) >= 15)
        score += 1
      end

      iterator += 1
      if iterator == 3
        break
      end
    end

    # check the score
    if score == 3
      return 1
    end
    return 0
  end



  def self.filter_roa(roa_input)
    # check if data exists
    data = Api::V1::CommonService.check_if_data_exists(roa_input)
    if data == false
      return 0
    end

    score = 0
    iterator = 0
    # iterate over the last 3 years
    data.each do |roa|
      if ((roa['value'] * 100) >= 6)
        score += 1
      end

      iterator += 1
      if iterator == 3
        break
      end
    end

    # check the score
    if score == 3
      return 1
    end
    return 0
  end



  def self.filter_dep(dep, gross_profit)
    # check if data exists
    data_dep = Api::V1::CommonService.check_if_data_exists(dep)
    if data_dep == false
      return 0
    end

    data_gross = Api::V1::CommonService.check_if_data_exists(gross_profit)
    if data_gross == false
      return 0
    end

    result = (data_dep[0]['value'] / data_gross[0]['value']) * 100

    if result <= 8
      return 2
    end

    if result <= 18 && result > 8
      return 1
    end
    return 0
  end

end