class ParentPagesController < ApplicationController
  before_action :set_children
  before_action :enable_header, :enable_navbar
  before_action :check_if_parent

  def events
  end

  def children
  end

  def point_store
  end

  def approve
    Attendance.find(params[:attendance_id]).update_attribute :attendance_status, "approved"
    flash[:success] = 'The event has been approved.'
    redirect_to events_path
  end

  def reject
    Attendance.find(params[:attendance_id]).update_attribute :attendance_status, "rejected"
    flash[:danger] = 'The event has been rejected.'
    redirect_to events_path
  end

  private
  def set_children
    @children = User.where(:parent_id => current_user.id)
  end

  def check_if_parent
    if current_user.role != "parent"
      flash[:danger] = 'You must be logged in as a parent to access this page.'
      redirect_to root_path
    end
  end
end
