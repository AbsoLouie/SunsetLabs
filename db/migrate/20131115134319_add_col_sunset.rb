class AddColSunset < ActiveRecord::Migration
  def change
    add_column :sunsets, :military_time, :string
  end
end
