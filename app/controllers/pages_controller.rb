class PagesController < ApplicationController
  before_action :enable_header, :enable_navbar
  before_action :set_calendar
  before_action :set_dashboard

  def home
    @page = "home"

  end

  def save_grid
    current_user.update_attribute :dashboard_grid, params[:dashboard_grid]
    flash[:success] = 'Your dashboard grid has been saved!'
    redirect_to root_path
  end

  private

  def set_dashboard
    if current_user.role == "parent"
      @dashboard_items = ["partials/dashboard/map", "partials/dashboard/events", "partials/dashboard/calendar", "partials/dashboard/event_attendance_history", "partials/dashboard/children"]
    elsif current_user.role == "child"
      @dashboard_items = ["partials/dashboard/map", "partials/dashboard/events", "partials/dashboard/calendar", "partials/dashboard/event_attendance_history", "partials/dashboard/today"]
    elsif current_user.role == "administrator"
      @dashboard_items = ["partials/dashboard/map", "partials/dashboard/events", "partials/dashboard/calendar"]
    elsif current_user.role == "organiser"
      @dashboard_items = ["partials/dashboard/map", "partials/dashboard/events", "partials/dashboard/calendar"]
    end

    @dashboard_grid = JSON.parse current_user.dashboard_grid
  end

  def set_calendar
    # Create arrays of events to fill calendar
    @pending_attendances = Array.new
    @future_attendances = Array.new
    @past_attendances = Array.new

    if current_user.role == "parent"
      @children = User.where(parent_id:current_user.id)
      @children.each do |child|
        child.attendances.pending.each do |attendance|
          @pending_attendances << attendance
        end
        child.attendances.approved.each do |attendance|
          @future_attendances << attendance
        end
        child.attendances.attended.each do |attendance|
          @past_attendances << attendance
        end
      end
    end

    if current_user.role == "child"
      current_user.attendances.pending.each do |attendance|
        @pending_attendances << attendance
      end
      current_user.attendances.approved.each do |attendance|
        @future_attendances << attendance
      end
      current_user.attendances.attended.each do |attendance|
        @past_attendances << attendance
      end
    end

    @pending_events = Array.new
    @future_events = Array.new
    @past_events = Array.new

    if current_user.role == "parent"
      @pending_attendances.each do |attendance|
        @pending_events << ["<a href=\"\/events\/#{attendance.event_id}\">#{Event.find(attendance.event_id).event_name} (#{User.find(attendance.user_id).first_name})<\/a>", Event.find(attendance.event_id).event_date.to_s]
      end
      @future_attendances.each do |attendance|
        @future_events << ["<a href=\"\/events\/#{attendance.event_id}\">#{Event.find(attendance.event_id).event_name} (#{User.find(attendance.user_id).first_name})<\/a>", Event.find(attendance.event_id).event_date.to_s]
      end
      @past_attendances.each do |attendance|
        @past_events << ["<a href=\"\/events\/#{attendance.event_id}\">#{Event.find(attendance.event_id).event_name} (#{User.find(attendance.user_id).first_name})<\/a>", Event.find(attendance.event_id).event_date.to_s]
      end
    end

    if current_user.role == "child"
      @pending_attendances.each do |attendance|
        @pending_events << ["<a href=\"\/events\/#{attendance.event_id}\">#{Event.find(attendance.event_id).event_name}<\/a>", Event.find(attendance.event_id).event_date.to_s]
      end
      @future_attendances.each do |attendance|
        @future_events << ["<a href=\"\/events\/#{attendance.event_id}\">#{Event.find(attendance.event_id).event_name}<\/a>", Event.find(attendance.event_id).event_date.to_s]
      end
      @past_attendances.each do |attendance|
        @past_events << ["<a href=\"\/events\/#{attendance.event_id}\">#{Event.find(attendance.event_id).event_name}<\/a>", Event.find(attendance.event_id).event_date.to_s]
      end
    end
  end
end
