# frozen_string_literal: true

module Api
  module V1
    module Github
      class UsersController < BaseController
        include ResponseSelector

        def show
          res = client.get("/users/#{github_user.github_name}")

          render json: { success: true, data: select_expected_data(res) }
        end
      end
    end
  end
end
