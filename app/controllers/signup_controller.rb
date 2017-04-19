class SignupController < ApplicationController
  before_action :check_if_parent, only: [:child]

  def parent
    @user = User.new
  end

  def organiser
    @user = User.new
  end

  def child
    @user = User.new
    @parent_id = current_user.id
  end

  def admin
    @user = User.new
  end

  def create_user
    @role = params[:role]
    @user = User.new :email => params[:email], :password => params[:password],
                        :password_confirmation => params[:password_confirmation],
                        :first_name => params[:first_name], :last_name => params[:last_name],
                        :dob => params[:dob], :sex => params[:sex],
                        :address_line1 => params[:address_line1], :address_line2 => params[:address_line2],
                        :address_suburb => params[:address_suburb], :address_state => params[:address_state],
                        :address_pcode => params[:address_pcode], :parent_id => params[:parent_id],
                        :organisation => params[:organisation], :role => @role
    if @user.save
      redirect_to root_path, notice: 'User was successfully created.'
    else
      if @role == "parent"
        render :parent
      elsif @role == "organiser"
        render :organiser
      elsif @role == "child"
        render :child
      elsif @role == "admin"
        render :admin
      end
    end
  end

  private
  def check_if_parent
    if user_signed_in?
      if current_user.role == "parent"
        redirect_to signup_child_path
      else
        redirect_to root_path, notice: 'You must be logged in as a parent to create a child account.'
      end
    else
      redirect_to new_user_session_path, notice: 'You must be logged in as a parent to create a child account.'
    end
  end
end
