class User < ActiveRecord::Base
  has_secure_password validations: true

  has_one :github_user

  validates :mail, presence: true, uniqueness: true
end
