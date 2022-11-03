# frozen_string_literal: true

class GithubRepository < ApplicationRecord
  belongs_to :github_user, foreign_key: :owner_id

  scope :active, -> { where(deleted_at: nil) }
end
