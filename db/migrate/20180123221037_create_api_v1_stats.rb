class CreateApiV1Stats < ActiveRecord::Migration[5.1]
  def change
    create_table :api_v1_stats do |t|
      t.string :ticker
      t.string :roe
      t.string :netincome
      t.string :freecashflow
      t.string :profitmargin
      t.string :longtermdebt
      t.string :grossmargin
      t.string :roa
      t.string :depreciationexpense
      t.string :totalgrossprofit
      t.string :close_price
      t.string :pricetoearnings
      t.string :bookvaluepershare

      t.timestamps
    end
    add_index :api_v1_stats, :ticker, unique: true
  end
end
