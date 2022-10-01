module ProviderLogin
  class GithubUserCreateService
    class << self
      def run(params, local_user)
        new(params, local_user).exec
      end
    end

    def initialize(params, local_user)
      @local_user = local_user
      @remote_user_params = params.dig(:extra, :raw_info)
                                  .slice(:id, :login, :avatar_url)
    end

    def exec
      build_github_user
      set_name_local_user
      @local_user.save
    end

    private

    def build_github_user
      @remote_user_params.transform_keys! do |key|
        next key unless GithubUser::REMOTE_KEY_TRANSFORM_MAP[key]

        GithubUser::REMOTE_KEY_TRANSFORM_MAP[key]
      end
      @local_user.build_github_user(@remote_user_params)
    end

    def set_name_local_user
      @local_user.name = @remote_user_params[:login]
    end
  end
end
