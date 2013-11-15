class CreateFullmoon < ActiveRecord::Migration
  def change
    create_table :fullmoons do |t|
      t.boolean :fullmoon
    end
  end
end
