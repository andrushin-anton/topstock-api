class CreateApiV1Companies < ActiveRecord::Migration[5.1]
  def change
    create_table :api_v1_companies do |t|
      t.string :name
      t.string :ticker
      t.string :sector
      t.string :industry
      t.string :country
      t.string :status
      t.string :rank

      t.timestamps
    end
  end
end
