class CreateDistricts < ActiveRecord::Migration
  def self.up
    create_table :districts do |t|
      t.string :code
      t.string :title
      t.string :address
      t.string :city
      t.string :province
      t.string :postal
      t.string :mailing_address
      t.string :mailing_city
      t.string :mailing_province
      t.string :mailing_postal
      t.string :website
      t.string :phone
      t.string :fax

      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :districts
  end
end
