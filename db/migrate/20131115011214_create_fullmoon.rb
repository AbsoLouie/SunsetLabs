class CreateFullmoon < ActiveRecord::Migration
  def change
    create_table :fullmoons do |t|
      t.boolean :fullmoon
     
      t.timestamps
    end
  end
end
