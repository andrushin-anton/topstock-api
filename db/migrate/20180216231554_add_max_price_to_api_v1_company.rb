class AddMaxPriceToApiV1Company < ActiveRecord::Migration[5.1]
  def change
    add_column :api_v1_companies, :max_price, :string
  end
end
