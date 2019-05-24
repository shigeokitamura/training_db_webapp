class Order < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :bought, class_name: "Course"

  validates :buyer_id, presence: true
  validates :bought_id, presence: true
end
