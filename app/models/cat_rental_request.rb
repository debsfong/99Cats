class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(Pending Approved Denied),
    message: "%{value} is not a valid status" }
  validate :overlapping_approved_requests

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

  def overlapping_requests
    overlap_before = CatRentalRequest.where("start_date < ? AND end_date > ?", self.start_date, self.start_date)
    overlap_after = CatRentalRequest.where("start_date > ? AND start_date < ?", self.start_date, self.end_date)
    overlap_after + overlap_before
  end

  def overlapping_approved_requests
    overlaps = overlapping_requests
    if overlaps.any? { |request| request.status == "Approved" }
      errors[:overlap] << "that is overlapping with another."
    end
  end
end

# CatRentalRequest.create(cat_id: 3, start_date: "2016/02/02", end_date: "2016/03/02", status: "Approved")
# a = CatRentalRequest.create(cat_id: 3, start_date: "2016/02/12", end_date: "2016/03/12")
# b = CatRentalRequest.create(cat_id: 3, start_date: "2016/01/02", end_date: "2016/02/12")
# c = CatRentalRequest.create(cat_id: 3, start_date: "2016/01/12", end_date: "2016/03/12")
# d = CatRentalRequest.create(cat_id: 3, start_date: "2016/02/12", end_date: "2016/02/22")
