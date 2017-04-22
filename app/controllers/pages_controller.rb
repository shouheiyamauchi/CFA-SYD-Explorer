class PagesController < ApplicationController
  before_action :enable_header, :enable_navbar

  def home
  end

  def test3
    @dashboard_grid = JSON.parse current_user.dashboard_grid
  end

  def save_grid
    current_user.update_attribute :dashboard_grid, params[:dashboard_grid]
    redirect_to pages_test3_path
  end
end
