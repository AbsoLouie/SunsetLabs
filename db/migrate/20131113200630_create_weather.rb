class CreateWeather < ActiveRecord::Migration
  def change
    create_table :sunsets do |t|
      t.string :sunset_time

      t.timestamps
    end
  end
end
