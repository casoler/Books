class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,   :limit => 25, :default => "", :null => false
      t.string :password,   :limit => 25, :default => "", :null => false
	  t.string :first_name, :limit => 25, :default => "", :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
