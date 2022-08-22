module Github
  class BaseJob < ApplicationJob

    private

    def client
      @client ||= ::Github::Client.get_client
    end

    def auth_client(token)
      @auth_client ||= ::Github::Client.get_auth_client(token)
    end
  end
end
