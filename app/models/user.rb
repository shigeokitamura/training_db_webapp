class User < ApplicationRecord
  self.table_name = "users"

  validates :user_id,
            presence: true,
            length: { maximum: 20 },
            uniqueness: true

  validates :user_name,
            presence: true,
            length: { maximum: 50 },
            uniqueness: true

  validates :age,
            presence: true,
            length: { maximum: 2 }

  validates :dept,
            presence: true,
            length: { maximum: 2 }

  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 6 }
end

# rails g model User --migration false
# rails g migration add_password_digest_to_users password_digest:string
# rails db:migrate
