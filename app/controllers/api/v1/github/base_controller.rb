# frozen_string_literal: true

module Api
  module V1
    module Github
      class BaseController < Api::V1::ApiController
        before_action :set_github_user
        before_action :set_client

        private

        attr_reader :client, :github_user

        def set_github_user
          @github_user = ::GithubUser.find(params[:id])
        end

        def set_client
          @client = ::Github::Client.new(github_user.auth_token)
        end
      end
    end
  end
end
