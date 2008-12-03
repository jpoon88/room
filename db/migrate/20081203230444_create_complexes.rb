class CreateComplexes < ActiveRecord::Migration
  def self.up
    create_table :complexes, :options => "ENGINE=MyISAM" do |t|
      t.string :title
      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :complexes
  end
end
