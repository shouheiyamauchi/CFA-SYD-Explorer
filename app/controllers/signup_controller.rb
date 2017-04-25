class SignupController < ApplicationController
  before_action :enable_header, :enable_footer
  before_action :enable_navbar, only: [:child]
  before_action :parent_logged_in, only: [:child]
  before_action :logged_in, only: [:parent, :organiser]
  skip_before_action :authenticate_user!, only: [:parent, :organiser, :child, :create_user]

  def parent
    @user = User.new
    @role = 'parent'
  end

  def organiser
    @user = User.new
    @role = 'organiser'
  end

  def child
    @user = User.new
    @parent_id = current_user.id
    @role = 'child'
  end

  def admin
    @user = User.new
    @role = 'administrator'
  end

  def create_user
    @role = params[:role]
    @user = User.new :email => params[:email], :password => params[:password],
                        :password_confirmation => params[:password_confirmation],
                        :first_name => params[:first_name], :last_name => params[:last_name],
                        :dob => params[:dob], :sex => params[:sex],
                        :address_line1 => params[:address_line1], :address_line2 => params[:address_line2],
                        :address_suburb => params[:address_suburb], :address_state => params[:address_state],
                        :address_pcode => params[:address_pcode], :autoapprove => params[:autoapprove],
                        :organisation => params[:organisation], :role => @role
    if @role == "child"
      @user.parent_id = current_user.id
    end

    # Assign default dashboard grid
    if @role == 'parent'
      @user.dashboard_grid = "[\r\n    {\r\n        \"id\": \"map\",\r\n        \"x\": 0,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 21\r\n    },\r\n    {\r\n        \"id\": \"events\",\r\n        \"x\": 0,\r\n        \"y\": 34,\r\n        \"width\": 6,\r\n        \"height\": 17\r\n    },\r\n    {\r\n        \"id\": \"calendar\",\r\n        \"x\": 6,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 48\r\n    },\r\n    {\r\n        \"id\": \"event_attendance_history\",\r\n        \"x\": 0,\r\n        \"y\": 51,\r\n        \"width\": 6,\r\n        \"height\": 14\r\n    },\r\n    {\r\n        \"id\": \"children\",\r\n        \"x\": 0,\r\n        \"y\": 21,\r\n        \"width\": 6,\r\n        \"height\": 13\r\n    }\r\n]"
    elsif @role == 'organiser'
      @user.dashboard_grid = "[\r\n    {\r\n        \"id\": \"map\",\r\n        \"x\": 0,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 21\r\n    },\r\n    {\r\n        \"id\": \"events\",\r\n        \"x\": 0,\r\n        \"y\": 21,\r\n        \"width\": 6,\r\n        \"height\": 17\r\n    },\r\n    {\r\n        \"id\": \"calendar\",\r\n        \"x\": 6,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 48\r\n    }\r\n]"
    elsif @role == 'child'
      @user.dashboard_grid = "[\r\n    {\r\n        \"id\": \"map\",\r\n        \"x\": 0,\r\n        \"y\": 15,\r\n        \"width\": 6,\r\n        \"height\": 21\r\n    },\r\n    {\r\n        \"id\": \"events\",\r\n        \"x\": 0,\r\n        \"y\": 36,\r\n        \"width\": 6,\r\n        \"height\": 17\r\n    },\r\n    {\r\n        \"id\": \"calendar\",\r\n        \"x\": 6,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 48\r\n    },\r\n    {\r\n        \"id\": \"event_attendance_history\",\r\n        \"x\": 0,\r\n        \"y\": 53,\r\n        \"width\": 6,\r\n        \"height\": 14\r\n    },\r\n    {\r\n        \"id\": \"today\",\r\n        \"x\": 0,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 15\r\n    }\r\n]"
    elsif @role == 'administrator'
      @user.dashboard_grid = "[\r\n    {\r\n        \"id\": \"map\",\r\n        \"x\": 0,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 21\r\n    },\r\n    {\r\n        \"id\": \"events\",\r\n        \"x\": 0,\r\n        \"y\": 21,\r\n        \"width\": 6,\r\n        \"height\": 17\r\n    },\r\n    {\r\n        \"id\": \"calendar\",\r\n        \"x\": 6,\r\n        \"y\": 0,\r\n        \"width\": 6,\r\n        \"height\": 48\r\n    }\r\n]"
    end

    if @user.save
      if @role == 'parent' || @role == 'organiser'
        flash[:success] = 'Thank you for signing up! Please log in using your e-mail and password.'
        redirect_to new_user_session_path
      elsif @role == 'child'
        flash[:success] = 'Thank you for signing up! Your child can now log in using their e-mail and password.'
        redirect_to root_path
      elsif @role == 'administrator'
        redirect_to root_path
      end
    else
      if @role == 'parent'
        render :parent
      elsif @role == 'organiser'
        render :organiser
      elsif @role == 'child'
        render :child
      elsif @role == 'administrator'
        render :admin
      end
    end
  end

  private
  def logged_in
    if user_signed_in?
      flash[:danger] = 'You cannot sign up while logged in.'
      redirect_to root_path
    end
  end

  def parent_logged_in
    if user_signed_in?
      if current_user.role != 'parent'
        flash[:danger] = 'You must be logged in as a parent to create a child account.'
        redirect_to root_path
      end
    else
      flash[:danger] = 'You must be logged in as a parent to create a child account.'
      redirect_to new_user_session_path
    end
  end
end
