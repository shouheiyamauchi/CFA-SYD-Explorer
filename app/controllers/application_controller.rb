class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def enable_header
    @enable_header = true
  end

  def enable_navbar
    @enable_navbar = true
  end
end
