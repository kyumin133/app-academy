# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :student_enrollments,
    primary_key: :id,
    foreign_key: :student_id,
    class_name: :Enrollment

  has_many :courses_taught,
    primary_key: :id,
    foreign_key: :instructor_id,
    class_name: :Course

  has_many :courses_enrolled,
    through: :student_enrollments,
    source: :course
end
