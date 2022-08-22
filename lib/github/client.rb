module Github
  class Client
    # TODO: move to ".env"
    GITHUB_API_BASE_URL = "https://api.github.com"
    TIME_OUT_SEC = 5

    class << self
      def get_client
        new
      end

      def get_auth_client(auth_token)
        new(auth_token)
      end
    end

    def initialize(auth_token = {})
      @auth_token = auth_token
      @client = HTTPClient.new
      configure_client
    end

    # NOTE: path = "/{path}"
    def get(path, query_params = {}, header: default_header)
      url = GITHUB_API_BASE_URL + path
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
