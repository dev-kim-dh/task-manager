# frozen_string_literal: true

module Github
  class SyncPullRequestJob < BaseJob
    queue_as :default

    sidekiq_options retry: false

    # NOTE: API에서 받아온 속성의 키가 DB와 맞지않을 경우,
    #       이 맵을 기준으로하여 키를 변경한다.
    #       key from github api => db column name
    REMOTE_TO_DB_ATTR_KEY_MAP = {
      id: :remote_id
    }.freeze

    SYNC_COLUMN = %i[id title state body merge_commit_sha remote_created_at remote_updated_at remote_closed_at remote_merge_at].freeze

    def perform
      target_repositories.each do |repo|
        pull_requests = client.get("#{repo.url}/pulls")
        build_pull_requests(pull_requests)
      end
    end

    private

    def target_repositories
      @target_repositories ||= GithubRepository.active
    end

    def build_pull_requests(pull_requests)
      built_pull_requests = pull_requests.flat_map do |pull_request|
        pr_owner = GithubUser.find_by(remote_id: pull_request.dig(:user, :id))
        next unless pr_owner

        pr_info = slice_and_transform_remote_keys(pull_request)
        pr_owner.github_pull_requests.build(pr_info)
      end

      GithubPullRequest.import built_pull_requests
    end

    def pr_owner_exists?(owner_id)
      GithubUser.find_by(remote_id: owner_id)
    end

    def transform_remote_keys(pull_request)
      pull_request.slice(SYNC_COLUMN).transform_keys do |key|
        next key unless REMOTE_TO_DB_ATTR_KEY_MAP[key]

        REMOTE_TO_DB_ATTR_KEY_MAP[key]
      end
    end
  end
end
