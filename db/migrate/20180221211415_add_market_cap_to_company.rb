class AddMarketCapToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :api_v1_companies, :market_cap, :float
  end
end
