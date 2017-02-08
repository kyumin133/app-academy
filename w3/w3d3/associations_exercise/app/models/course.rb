# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  prereq_id     :integer
#  instructor_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Course < ActiveRecord::Base
  has_many :course_enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Enrollment

  belongs_to :instructor,
    primary_key: :id,
    foreign_key: :instructor_id,
    class_name: :User

  has_many :students,
    through: :course_enrollments,
    source: :student

  belongs_to :prereq,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: :Course

  has_many :is_prereq_for,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: :Course
end
