class PagesController < ApplicationController
  before_action :enable_header, :enable_navbar

  def home
    @dashboard_items = ["partials/dashboard/map", "partials/dashboard/events", "partials/dashboard/calendar", "partials/dashboard/event_attendance_history", "partials/dashboard/children"]
    @dashboard_grid = JSON.parse current_user.dashboard_grid
  end

  def test3
    @dashboard_grid = JSON.parse current_user.dashboard_grid
  end

  def test4
    @dashboard_items = ["partials/dashboard/map", "partials/dashboard/events", "partials/dashboard/calendar", "partials/dashboard/event_attendance_history", "partials/dashboard/children"]
    @dashboard_grid = JSON.parse current_user.dashboard_grid
  end

  def save_grid
    current_user.update_attribute :dashboard_grid, params[:dashboard_grid]
    redirect_to root_path
  end
end
