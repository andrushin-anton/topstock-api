require 'open-uri'
require 'csv'
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
    # Find companies needing pulling statistics
    companies = Api::V1::Company.where('status = ?', 'NEED_STATS').limit(10)

    companies.each do |company|
      # Update current status to RUNNING
      company.status = 'RUNNING'
      company.update

      # Pull the stats
      puts "Preparing to pull stats for: #{company.ticker},  #{company.name}"
      puts '................................................................'
      # ROE

    end
  end
end
