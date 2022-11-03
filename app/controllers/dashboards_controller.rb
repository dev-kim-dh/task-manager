# frozen_string_literal: true

class DashboardsController < ApplicationController
  include UserAuthentication

  def home
    redirect_to :login unless authenticate
  end
end
