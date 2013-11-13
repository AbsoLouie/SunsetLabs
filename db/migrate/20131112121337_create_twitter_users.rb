class CreateTwitterUsers < ActiveRecord::Migration
  def change 
    create_table(:twitter_users) do |t|
      t.string :name
    end
  end
end
