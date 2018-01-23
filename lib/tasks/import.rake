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

  end

  desc "Imports statistics for companies"
  task stats: :environment do
    # Find companies that need statistics
    Api::V1::Company.where('status = ?', 'NEED_STATS').limit(10).each do |company|
      # Update current status to RUNNING
      company.status = 'RUNNING'
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
      puts 'ClosePrice'
      Utilities::pull_historic_data(statistics, 'close_price')
      puts 'PriceToEarnings'
      Utilities::pull_historic_data(statistics, 'pricetoearnings')
      puts 'BookValuePerShare'
      Utilities::pull_historic_data(statistics, 'bookvaluepershare')

      # statistics were pulled update the company status
      company.status = 'NEED_CALCULATIONS'
      company.save
      # save statistics
      statistics.save
      puts 'SAVED'

    end
  end
end
