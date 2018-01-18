class CreateApiV1Industries < ActiveRecord::Migration[5.1]
  def change
    create_table :api_v1_industries do |t|
      t.string :name
      t.string :profitmargin

      t.timestamps
    end
  end
end
