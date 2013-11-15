class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :weather
      t.string :temp_f
      t.string :wind_string
      t.string :wind_dir
      t.string :visibility_mi
      t.string :precip_1hr_string

      t.timestamps
    end
  end
end
