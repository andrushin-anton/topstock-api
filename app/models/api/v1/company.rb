require_relative '../../../services/api/v1/fundamental_service'
require_relative '../../../services/api/v1/economic_moat_service'
require_relative '../../../services/api/v1/real_price_service'

class Api::V1::Company < ApplicationRecord

  STATUS_CALCULATED = 'CALCULATED'
  # Company that needs statistics to be pulled in
  STATUS_NEED_STATS = 'NEED_STATS'
  # Company that needs its RANK to be re-calculated
  STATUS_NEED_CALCULATIONS = 'NEED_CALCULATIONS'
  # Some of the processes is currently running for this company
  STATUS_RUNNING = 'RUNNING'

  # The method that calculates companies ranks
  def self.recalculate_rank(status)

    # Find companies that need RANK calculation
    Api::V1::Company.where('status = ?', status).order('updated_at ASC').each do |company|
      # fundamental
      result_fundamental = Api::V1::FundamentalService.calculate(company)

      # economic moat
      result_moat = Api::V1::EconomicMoatService.calculate(company)

      # find out the real stock price
      max_buy_price = Api::V1::RealPriceService.calculate(company)

      # company RANK
      company_rank = Api::V1::Company.find_out_company_rank(result_fundamental, result_moat, max_buy_price)

      # update rank and status
      company.rank = company_rank
      company.status = self::STATUS_CALCULATED
      company.save

    end

  end

  # The method that finds out the current company's RANK based on its stats
  def self.find_out_company_rank(result_fundamental, result_moat, max_buy_price)
    # The highest rank is 5 when
    # result_fundamental == Api::V1::FundamentalService::EXCELLENT
  end

  # Helper method that creates a new company if it is not already exists
  def self.create_company_if_not_exists_from_csv_line(csv_line, exchange_name)
    # ignore if sector is n/a or empty - because it is not a company
    unless csv_line[6].downcase == 'n/a' || csv_line[6] == ''
      company = Api::V1::Company.where('ticker = ?', csv_line[0]).first

      unless company.nil?
        # update
        company.ticker = csv_line[0]
        company.name = csv_line[1]
        company.price = csv_line[2]
        company.exchange = exchange_name
        company.sector = csv_line[6]
        company.industry = csv_line[7]
        company.status = company.status == self::STATUS_NEED_STATS ? self::STATUS_NEED_STATS : self::STATUS_NEED_CALCULATIONS
        company.save
        puts "#{csv_line[0]} updated!"
      else
        company = Api::V1::Company.new
        company.name = csv_line[1]
        company.price = csv_line[2]
        company.exchange = exchange_name
        company.sector = csv_line[6]
        company.industry = csv_line[7]
        company.status = self::STATUS_NEED_STATS
        company.rank = '0'
        company.save
        puts "#{csv_line[0]} created!"
      end
    end
  end

end
