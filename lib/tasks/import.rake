require 'open-uri'
require 'csv'
require 'http'
require 'json'
require_relative '../../lib/utilities'

namespace :import do

  desc "Imports companies"
  task companies: :environment do
    # Add companies from AMEX
    companies = Utilities::read_remote_csv('http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX&render=download')
    companies.each do |line|
      Api::V1::Company::create_company_if_not_exists_from_csv_line(line, 'AMEX')
    end

    # Add companies from NASDAQ
    companies = Utilities::read_remote_csv('http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&render=download')
    companies.each do |line|
      Api::V1::Company::create_company_if_not_exists_from_csv_line(line, 'NASDAQ')
    end

    # Add companies from AMEX
    companies = Utilities::read_remote_csv('http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE&render=download')
    companies.each do |line|
      Api::V1::Company::create_company_if_not_exists_from_csv_line(line, 'NYSE')
    end

    # Now it is a good time to recalculate companies RANK
    # Only for those having status 'NEED_CALCULATIONS'
    Api::V1::Company.recalculate_rank(Api::V1::Company::STATUS_NEED_CALCULATIONS)

  end

  desc "Imports statistics for companies"
  task stats: :environment do
    # Find companies that need statistics
    Api::V1::Company.where('status = ?', Api::V1::Company::STATUS_NEED_STATS).order('updated_at ASC').limit(10).each do |company|
      # Update current status to RUNNING
      company.status = Api::V1::Company::STATUS_RUNNING
      company.save
      # Find statistics row or initialize new for a given company
      statistics = Api::V1::Stats.find_by_ticker(company.ticker)

      # Pull the stats
      puts "Preparing to pull stats for: #{company.ticker},  #{company.name}"
      puts '................................................................'
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

      # statistics were pulled update the company status
      company.status = Api::V1::Company::STATUS_NEED_CALCULATIONS
      company.save
      # save statistics
      statistics.save
      puts 'SAVED'

    end
    # Now it is a good time to recalculate companies RANK
    # Only for those having status 'NEED_CALCULATIONS'
    Api::V1::Company.recalculate_rank(Api::V1::Company::STATUS_NEED_CALCULATIONS)
  end

  desc "Recalculates rank for companies(optional for testing purposes)"
  task rank_calculate: :environment do
    # Only for those having status 'NEED_CALCULATIONS'
    Api::V1::Company.recalculate_rank(Api::V1::Company::STATUS_NEED_CALCULATIONS)
  end
end
