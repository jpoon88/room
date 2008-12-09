class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :school_id
      t.integer :year      
      t.string :category      
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :email
      
      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
