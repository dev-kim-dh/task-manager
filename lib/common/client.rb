# frozen_string_literal: true

module Common
  # Common Api Client
  class Client
    TIME_OUT_SEC = 5

    class << self
      def init_client
        new
      end
    end

    def initialize
      @client = HTTPClient.new
      configure_client
    end

    # NOTE: path = "/{path}"
    def get(url, query_params = {}, header: default_header)
      res = client.get(url, query: query_params, header: header)

      JSON.parse(res.body, symbolize_names: true)
    end

    private

    attr_reader :client

    def default_header
      return if @auth_token.blank?

      {
        "Authorization" => "token #{@auth_token}"
      }
    end

    def configure_client
      client.receive_timeout = TIME_OUT_SEC
    end
  end
end
