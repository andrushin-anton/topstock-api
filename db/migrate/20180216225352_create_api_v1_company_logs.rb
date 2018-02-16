class CreateApiV1CompanyLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :api_v1_company_logs do |t|
      t.string :ticker
      t.string :fundament
      t.string :moat
      t.string :max_price
      t.string :close_price
      t.string :rank

      t.timestamps
    end
  end
end
