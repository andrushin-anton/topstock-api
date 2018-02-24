class CreateApiV1Processors < ActiveRecord::Migration[5.1]
  def change
    create_table :api_v1_processors do |t|
      t.string :processor_type
      t.string :status
      t.datetime :run_time
      t.datetime :last_run_time
      t.string :processor_data
      t.string :last_error

      t.timestamps
    end
  end
end
