class DashboardsController < ApplicationController
  def index
    @github_user = fetch_github_user
    
    @repositories = fetch_github_user_repos
    binding.pry
  end

  private

  def github_client
    @github_client ||= ::Github::Client.new(current_github_user.auth_token)
  end

  def fetch_github_user
    github_client.get("/users/#{current_github_user.github_name}")
  end

  def fetch_github_user_repos
    github_client.get("/users/#{current_github_user.github_name}/repos")
  end
end
