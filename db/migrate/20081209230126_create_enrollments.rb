class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.integer :school_id
      t.integer :year
      t.integer :total
      t.integer :kh_enrollment
      t.integer :kf_enrollment
      t.integer :hs_registration
      t.integer :su_enrollment
      t.integer :eu_enrollment
      t.integer :grade_1
      t.integer :grade_2
      t.integer :grade_3
      t.integer :grade_4
      t.integer :grade_5
      t.integer :grade_6
      t.integer :grade_7
      t.integer :grade_8
      t.integer :grade_9
      t.integer :grade_10
      t.integer :grade_11
      t.integer :grade_12

      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :enrollments
  end
end
