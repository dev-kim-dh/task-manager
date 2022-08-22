module Github
  class SyncRepositoryJob < BaseJob
    queue_as :default

    sidekiq_options retry: false

    # NOTE: API에서 받아온 속성의 키가 DB와 맞지않을 경우,
    #       이 맵을 기준으로하여 키를 변경한다.
    #       key from github api => db column name
    REMOTE_TO_DB_ATTR_KEY_MAP = {
      :id => :remote_id
    }

    def perform(github_user)
      repos = fetch_repositories(github_user)
      repos.each do |repo|
        initialized_repo = if GithubRepository.find_by(remote_id: repo[:id])
                            update_github_repo(repo)
                          else
                            create_github_repo(repo)
                          end
        next unless repo_owner_exists?(repo.dig(:owner, :id))

        repo_owner = GithubUser.find_by(remote_id: repo.dig(:owner, :id))
        next unless repo_owner

        initialized_repo.owner_id = repo_owner.id
        initialized_repo.save
      end
    end

    private

    def fetch_repositories(github_user)
      client.get("/users/#{github_user.github_name}/repos")
    end

    def create_github_repo(repo)
      GithubRepository.new(
        sync_repo_keys_with_app(repo)
      )
    end

    def update_github_repo(repo)
      repo_in_app = GithubRepository.find_by(remote_id: repo[:id])
      return if repo_in_app.nil?

      repo_in_app.assign_attributes(
        sync_repo_keys_with_app(repo)
      )
      repo_in_app
    end

    def sync_repo_keys_with_app(repo)
      repo.slice(:id, :name, :url).transform_keys do |key|
        next key unless REMOTE_TO_DB_ATTR_KEY_MAP[key]

        REMOTE_TO_DB_ATTR_KEY_MAP[key]
      end
    end

    def repo_owner_exists?(owner_id)
      GithubUser.find_by(remote_id: owner_id)
    end
  end
end
