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
end

# rails g model User --migration false
# rails g migration add_password_digest_to_users password_digest:string
# rails db:migrate
