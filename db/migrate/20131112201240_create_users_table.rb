class CreateUsersTable < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :password_hash
    end
    
  end
end
