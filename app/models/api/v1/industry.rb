class Api::V1::Industry < ApplicationRecord

  def self.find_industry_avg_profit_margin(industry_name)
    industry = Api::V1::Industry.where('name LIKE ?', "%#{industry_name}%").first

    if industry.nil?
      # Not found - return 0%
      # TODO: save something into the logs to be able to add missing values
      return 0
    end

    return industry.profitmargin.to_f
  end

end
