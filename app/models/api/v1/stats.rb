class Api::V1::Stats < ApplicationRecord

  def self.find_by_ticker(ticker)
    stats = Api::V1::Stats.where('ticker = ?', ticker).first
    if stats.nil?
      stats = Api::V1::Stats.new
      stats.ticker = ticker
    end
    return stats
  end

end
