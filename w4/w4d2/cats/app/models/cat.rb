require "date"

class Cat < ActiveRecord::Base
  COLORS = %w(black orange white brown)
  SEX = %w(M F)
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: SEX,
    message: "%{value} is not a valid sex" }

    #TODO: DOB can't be in the future
  validate :positive_age

  has_many :cat_rental_requests,
    dependent: :destroy

  def age
    now = Date.today
    dob = self.birth_date
    age = now.year - dob.year
    unless (now.month > dob.month) || ((now.month == dob.month) && (now.day > dob.day))
      age -= 1
    end
    age
  end

  def positive_age
    if self.age < 0
      self.errors[:Birth] = "date cannot be in the future"
    end
  end
end
