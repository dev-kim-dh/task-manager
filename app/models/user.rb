# frozen_string_literal: true

class User < ApplicationRecord

  has_one :github_user

  validates :name, presence: true, uniqueness: true

  scope :find_with_provider_user_id, lambda { |provider, provider_user_id|
    provider_table = "#{provider}_user".to_sym

    joins(provider_table).find_by(provider_table => { remote_id: provider_user_id })
  }
end
