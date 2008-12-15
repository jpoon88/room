class School < ActiveRecord::Base
  belongs_to :district
  has_many   :grades
  has_many   :contacts
  has_many   :enrollments
  
end
