# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UserAuthentication

  # before_action :authenticate_user
  # before_action :set_current_github_user

  attr_reader :current_user, :current_github_user

  private

  def authenticate_user
    redirect_to root_url and return unless authenticate
  end

  def set_current_github_user
    @current_github_user = current_user.github_user
  end
end
