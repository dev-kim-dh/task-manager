# frozen_string_literal: true

class GithubUser < ApplicationRecord
  REMOTE_KEY_TRANSFORM_MAP = {
    id: :remote_id
  }.freeze

  belongs_to :user

  has_many :github_repositories, foreign_key: :owner_id
  has_many :github_pull_requests, foreign_key: :owner_id

  validates :remote_id, presence: true,
                        uniqueness: true
  validates :user_id, presence: true,
                      uniqueness: true
  validates :login, presence: true,
                      uniqueness: true

  scope :find_with_remote_id, lambda { |remote_id|
    provider_table = "#{provider}_user".to_sym
    joins(:user).find_by(remote_id: remote_id)
    
  }
end
