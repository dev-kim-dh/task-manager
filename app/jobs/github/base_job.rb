# frozen_string_literal: true

module Github
  class BaseJob < ApplicationJob
    private

    def client
      @client ||= ::Common::Client.init_client
    end

    def github_client
      @github_client ||= ::Github::Client.init_client
    end

    def auth_client(token)
      @auth_client ||= ::Github::Client.get_auth_client(token)
    end
  end
end
