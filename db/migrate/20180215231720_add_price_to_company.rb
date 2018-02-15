class AddPriceToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :api_v1_companies, :price, :string
  end
end
