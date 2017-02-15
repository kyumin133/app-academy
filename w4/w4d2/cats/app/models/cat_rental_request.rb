class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUSES, message: "Cat must have a valid status"}

  validate :overlapping_approved_requests
  validate :end_after_start
  validate :not_in_past
  belongs_to :cat


  def overlapping_requests
    other_requests = cat.cat_rental_requests.where.not(id: self.id)
    other_requests.select do |request|
      (request.end_date > self.start_date) && (request.start_date < self.end_date)
    end
  end

  def overlapping_approved_requests
    approved_overlap = overlapping_requests.select do |request|
      request.status == "APPROVED"
    end

    unless approved_overlap.empty?
      self.errors[:Cat] = "is already rented during this time."
    end
  end

  def overlapping_pending_requests
    pending_overlap = overlapping_requests.select do |request|
      request.status == "PENDING"
    end
  end

  def approve!
    self.status = "APPROVED"
    pending_overlap = overlapping_pending_requests
    CatRentalRequest.transaction do
      self.save
      pending_overlap.each do |request|
        request.deny!
      end
    end
  end

  def pending?
    self.status == "PENDING"
  end


  def deny!
    self.status = "DENIED"
    self.save
  end

  def end_after_start
    if self.end_date < self.start_date
      self.errors[:End] = "date cannot be before start date"
    end
  end

  def not_in_past
    if self.end_date < Date.today || self.start_date < Date.today
      self.errors[:Date] = "cannot be in the past"
    end
  end
end
