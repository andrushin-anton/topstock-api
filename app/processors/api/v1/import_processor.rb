require 'open-uri'
require 'csv'
require 'http'
require 'json'
require_relative '../../../../lib/utilities'

class ImportProcessor


  def initialize(processor)
    @processor = processor
  end



  def run()
    # Add companies from AMEX
    companies = Utilities::read_remote_csv('https://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX&render=download')
    companies.each do |line|
      Api::V1::Company::create_company_if_not_exists_from_csv_line(line, 'AMEX')
    end

    # Add companies from NASDAQ
    companies = Utilities::read_remote_csv('https://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&render=download')
    companies.each do |line|
      Api::V1::Company::create_company_if_not_exists_from_csv_line(line, 'NASDAQ')
    end

    # Add companies from AMEX
    companies = Utilities::read_remote_csv('https://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE&render=download')
    companies.each do |line|
      Api::V1::Company::create_company_if_not_exists_from_csv_line(line, 'NYSE')
    end

    @processor.last_run_time = DateTime.now
    @processor.run_time = get_next_run_time
    @processor.status = Api::V1::Processor::STATUS_ACTIVE
    @processor.save

    puts "Import Processor finished!"
  end



  def get_next_run_time
    # run this import task once a day
    return 1.day.from_now
  end

end