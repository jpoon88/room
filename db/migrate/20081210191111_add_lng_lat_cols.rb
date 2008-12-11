class AddLngLatCols < ActiveRecord::Migration
  def self.up
    add_column :districts, :lat, :decimal, :precision => 20, :scale => 14
    add_column :districts, :lng, :decimal, :precision => 20, :scale => 14
    
    add_column :schools, :lat, :decimal, :precision => 20, :scale => 14
    add_column :schools, :lng, :decimal, :precision => 20, :scale => 14
  end

  def self.down
    remove_column :districts, :lat
    remove_column :districts, :lng
    
    remove_column :schools, :lat
    remove_column :schools, :lng
  end
end
