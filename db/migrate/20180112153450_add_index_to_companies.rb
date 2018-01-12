class AddIndexToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_index :api_v1_companies, :ticker, :unique=> true
  end
end
