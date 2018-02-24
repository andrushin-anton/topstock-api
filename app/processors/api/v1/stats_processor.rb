class StatsProcessor

  def initialize(processor)
    @processor = processor
  end

  def run()
    # get the cursor

    # find the next after the cursor company

    # pull in the data

    # update status to STATUS_NEED_CALCULATIONS

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

    @processor.last_run_time = DateTime.now
    @processor.run_time = get_next_run_time
    @processor.status = Api::V1::Processor::STATUS_ACTIVE
    @processor.save

    puts "Stats Processor finished!"
  end



  def get_next_run_time
    # run this import task once a day
    return 1.day.from_now
  end

end