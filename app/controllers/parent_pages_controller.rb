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
