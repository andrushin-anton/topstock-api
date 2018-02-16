class Api::V1::RealPriceService

  # Starting point
  def self.calculate(company)
    stats = Api::V1::Stats.find_by_ticker(company.ticker)

    # current book value per share
    current_book_value = Api::V1::RealPriceService.current_book_value_per_share(stats.bookvaluepershare)

    # the 3 year average ROE
    avg_roe_value = Api::V1::RealPriceService.avg_roe(stats.roe)

    # the lowest PE ratio over the last 3 years
    lowest_pe_value = Api::V1::RealPriceService.lowest_pe(stats.pricetoearnings)

    # 1 calculate the projected per share equity value 3 years hence: bookvaluepershare * (1 + (avg3yearsROE)^3)
    projected_book_value_per_share_value = Api::V1::RealPriceService.projected_book_value_per_share(current_book_value, avg_roe_value)

    # 2 estimate the per share earnings 3 years in the future: projected_book_value * avg_roe
    per_share_earnings_in_future = (projected_book_value_per_share_value * avg_roe_value).round(2)

    # 3 estimate the share price in the future
    share_price_in_future = (per_share_earnings_in_future * lowest_pe_value).round(2)

    # Finally estimate the max buy price
    return Api::V1::RealPriceService.max_buy_price(share_price_in_future)
  end

  # Recommended discount rate of 24%
  def self.max_buy_price(share_price_in_future, discount_rate = 0.24, num_years = 3)
    return (share_price_in_future / ((1 + discount_rate)**num_years)).round(2)
  end

  def self.projected_book_value_per_share(current_book_value, avg_roe, num_years = 3)
    return (current_book_value * ((1 + avg_roe)**num_years)).round(2)
  end

  def self.current_book_value_per_share(bookvalue)
    data = Api::V1::CommonService.check_if_data_exists(bookvalue)
    if data == false
      return 0
    end

    return data[0]['value']
  end

  def self.avg_roe(roe, max_years = 3)
    data = Api::V1::CommonService.check_if_data_exists(roe)
    if data == false
      return 0
    end

    i = 1
    total = 0
    data.each do |row|
      if i <= max_years
        total += row['value']
      end
      i = i + 1
    end

    if i > max_years
      denominator = max_years
    else
      denominator = data.count
    end

    # AVG ROE
    return (total / denominator).round(2)
  end

  def self.lowest_pe(pe, max_years = 3)
    data = Api::V1::CommonService.check_if_data_exists(pe)
    if data == false
      return 0
    end

    i = 1
    pe_array = []
    data.each do |row|
      if i <= max_years
        pe_array << row['value']
      end
      i = i + 1
    end

    return pe_array.min
  end

end