# frozen_string_literal: true

class SessionController < ApplicationController
  include UserAuthentication

  before_action :find_or_initialize_user, only: :create

  def login
    render :login
  end

  def create
    if @user
      redirect_to :new_user
      return
    end
    case omniauth_body[:provider]
    when "github"
      ProviderLogin::GithubUserCreateService.run(omniauth_body, @user)
    else
      raise
    end
  end

  private

  def find_or_initialize_user
    @user = User.find_with_provider_user_id(*user_search_condition)
    @user ||= User.new
  end

  def user_search_condition
    remote_id = case omniauth_body[:provider]
                when "github"
                  omniauth_body.dig(:extra, :raw_info, :id)
                else
                  raise
                end

    [omniauth_body[:provider], remote_id]
  end

  def omniauth_body
    @omniauth_body ||= request.env["omniauth.auth"].deep_symbolize_keys
  end
end
