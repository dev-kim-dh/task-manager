class GithubUser < ActiveRecord::Base
  belongs_to :user

  has_many :github_repositories, foreign_key: :owner_id

  validates :remote_id, presence: true,
                        uniqueness: true
  validates :github_name, presence: true
  validates :github_email, presence: true,
                            uniqueness: true
  validates :avatar_url, presence: true
  validates :profile_url, presence: true
  validates :auth_token, presence: true
end
