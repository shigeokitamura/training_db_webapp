class User < ApplicationRecord
  self.table_name = "users"
end

# rails g model User --migration false
# rails g migration add_password_digest_to_users password_digest:string
# rails db:migrate