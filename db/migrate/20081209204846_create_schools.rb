class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.integer :district_id
      t.string :code
      t.string :name
      t.string :category
      t.string :funding_group
      t.string :school_type      
      t.string :address
      t.string :city
      t.string :province
      t.string :postal
      t.string :mailing_address
      t.string :mailing_city
      t.string :mailing_province
      t.string :mailing_postal
      t.string :phone
      t.string :fax

      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
