# frozen_string_literal: true

class UsersController < ApplicationController
  include UserAuthentication

  def new
    @user = User.new
  end

  def create
    @user = User.create!(params.require(:user).permit(%i[name]))
    set_cookie_to_login_user

    redirect_to root_url and return
  end

  private

  def user_params
    params.require(:user).permit(%i[name])
  end
end
