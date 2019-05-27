class User < ApplicationRecord
  self.table_name = "users"

  validates :user_id,
            presence: true,
            numericality: {
              only_integer: true
            },
            length: { maximum: 20 },
            uniqueness: true

  validates :user_name,
            presence: true,
            length: { maximum: 50 },
            format: { with: /\A[0-9A-Za-z\-\_\.]+\z/ },
            uniqueness: true

  validates :age,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            length: { maximum: 2 }

  validates :dept,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            length: { maximum: 2 }

  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 6 },
            format: { with: /\A[0-9A-Za-z]+\z/ }

  has_many :active_orders, class_name: "Order",
                           foreign_key: "buyer_id",
                           dependent: :destroy,
                           inverse_of: :buyer
  has_many :passive_orders, class_name: "Order",
                            foreign_key: "bought_id",
                            dependent: :destroy,
                            inverse_of: :bought
  has_many :buying, through: :active_orders, source: :bought
  has_many :buyers, through: :passive_orders

  # コースを購入する
  def buy(course)
    ActiveRecord::Base.transaction do
      buying << course
    end
  end

  # 購入をやめる
  def cancel(course)
    ActiveRecord::Base.transaction do
      active_orders.find_by(bought_id: course.course_id).destroy
    end
  end

  # 購入していたらtrueを返す
  def buying?(course)
    ActiveRecord::Base.transaction do
      buying.include?(course)
    end
  end

end

# rails g model User --migration false
# rails g migration add_password_digest_to_users password_digest:string
# rails db:migrate
