class Course < ApplicationRecord
  self.table_name = "course"

  validates :course_id,
            presence: true,
            length: { maximum: 20 },
            format: { with: /\A[0-9A-Za-z\-]+\z/ },
            uniqueness: true

  validates :course_title,
            presence: true,
            length: { maximum: 50 }

  validates :topic,
            length: { maximum: 100 }

  validates :day_length,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 7
            }

  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 999999
            }

  validates :level_id,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }

  validates :category,
            presence: true,
            length: { maximum: 40 },
            format: { with: /\A[0-9A-Za-z]+\z/ }

  has_many :active_orders, class_name: "Order",
                           foreign_key: "bought_id",
                           dependent: :destroy
  has_many :passive_orders, class_name: "Order",
                            foreign_key: "buyer_id",
                            dependent: :destroy
  has_many :buyers, through: :active_orders
  has_many :buying, through: :passive_orders, source: :bought
end
