class GithubRepository < ActiveRecord::Base
  belongs_to :github_user, foreign_key: :owner_id
end
