require_relative '../../app/processors/api/v1/import_processor'
require_relative '../../app/processors/api/v1/rank_processor'
require_relative '../../app/processors/api/v1/stats_processor'

namespace :invoker do

  desc "Runs one of the processors"
  task processor: :environment do
    # check if any processor is currently running
    running_processor = Api::V1::Processor.where('status = ?', Api::V1::Processor::STATUS_RUNNING).first
    unless running_processor.nil?
      puts "Processor #{running_processor.processor_type} is already running..."
      exit
    end

    # select one of the processors
    processor = Api::V1::Processor.where('run_time <= ?', DateTime.now).order('run_time ASC').first
    if processor.nil?
      puts "Nothing to launch, sleeping..."
      exit
    end

    puts "Running #{processor.processor_type} processor..."
    processor.status = Api::V1::Processor::STATUS_RUNNING
    processor.save
    case processor.processor_type
      when Api::V1::Processor::TYPE_STATS
        current_proc = StatsProcessor.new(processor)
      when Api::V1::Processor::TYPE_RANK
        current_proc = RankProcessor.new(processor)
      when Api::V1::Processor::TYPE_IMPORT
        current_proc = ImportProcessor.new(processor)
    end
    # launch it!
    current_proc.run
  end



end
