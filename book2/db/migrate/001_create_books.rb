class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string  :title, 			         :default => "", :null => false
      t.string  :author_last,  :limit => 25, :default => "", :null => false
      t.string  :author_first, :limit => 25, :default => "", :null => false
      t.integer :publish_year,               :default => 0,  :null => false
      t.integer :category_id,                                :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
