class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :code
      t.string :name
      t.string :title
      t.string :street_address
      t.string :locality
      t.string :region
      t.string :postal_code
      t.string :phone
      
      t.string :country
      t.string :url
      t.string :map_url
      
      t.integer :image_width
      t.integer :image_height
      t.string :image_url
      
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      
      t.boolean :repair
      t.boolean :sellappletvs
      t.boolean :sellipods
      t.boolean :selliphones
      t.boolean :applestore
      t.boolean :sellmacs
      t.string :concierge

      t.decimal :lat, :precision => 20, :scale => 14
      t.decimal :lng, :precision => 20, :scale => 14
      
      t.date :date_open      
      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end
