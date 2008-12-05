class CreateFacilities < ActiveRecord::Migration
  def self.up
    create_table :facilities  do |t|   # ,:options => "ENGINE=MyISAM"
      t.integer :complex_id
      t.string :title
      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :facilities
  end
end
