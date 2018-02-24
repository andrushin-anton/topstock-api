class RankProcessor

  def initialize(processor)
    @processor = processor
  end

  def run()
    # Only for those having status 'NEED_CALCULATIONS'
    Api::V1::Company.recalculate_rank(Api::V1::Company::STATUS_NEED_CALCULATIONS)

    @processor.last_run_time = DateTime.now
    @processor.run_time = get_next_run_time
    @processor.status = Api::V1::Processor::STATUS_ACTIVE
    @processor.save

    puts "Rank Processor finished!"
  end



  def get_next_run_time
    # run this processor every half an hour
    return 30.minutes.from_now
  end

end