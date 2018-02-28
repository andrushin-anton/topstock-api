class StatsProcessor

  # Number of calls per day
  API_CALLS_AVAILABLE = 500
  # Number of calls required for 1 company
  NUM_CALLS_PER_COMPANY = 11

  def initialize(processor)
    @processor = processor
  end

  def run()
    offset = 0
    # find out the offset
    processor_data = JSON.parse(@processor.processor_data)
    if processor_data.has_key?('OFFSET')
      offset = processor_data['OFFSET']
      puts "Working with offset: #{offset}"
    end
    # total
    total = Api::V1::Company.where.not(market_cap: [0]).count
    puts "Total: #{total}"
    # check if need to nul the offset
    if total == offset
      offset = 0
    end
    # find the next company
    company = Api::V1::Company.where.not(market_cap: [0]).order('market_cap DESC').offset(offset).first
    puts "Pulling data for company #{company.ticker}"
    # Update current status to RUNNING
    company.status = Api::V1::Company::STATUS_RUNNING
    company.save
    # Find statistics row or initialize new for a given company
    statistics = Api::V1::Stats.find_by_ticker(company.ticker)
    # Pull the stats
    puts "Preparing to pull stats for: #{company.ticker},  #{company.name}"
    puts '................................................................'
    offset = Utilities.pull_in_stats(company, statistics, offset)

    # upp the offset
    processor_data['OFFSET'] = offset
    @processor.processor_data = processor_data.to_json
    @processor.last_run_time = DateTime.now
    @processor.run_time = get_next_run_time
    @processor.status = Api::V1::Processor::STATUS_ACTIVE
    @processor.save

    puts "Stats Processor finished!"
  end



  def get_next_run_time
    # need to find the interval between the processor runs
    seconds_in_day = 86400
    number_of_companies_process_per_day = (API_CALLS_AVAILABLE / NUM_CALLS_PER_COMPANY).round
    next_run_time_in_sec = (seconds_in_day / number_of_companies_process_per_day).round

    return next_run_time_in_sec.seconds.from_now
  end

end