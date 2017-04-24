class SignupController < ApplicationController
  before_action :enable_header
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
    @role = 'admin'
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

    if @user.save
      if @role == 'parent' || @role == 'organiser'
        flash[:success] = 'Thank you for signing up! Please log in using your e-mail and password.'
        redirect_to new_user_session_path
      elsif @role == 'child'
        flash[:success] = 'Thank you for signing up! Your child can now log in using their e-mail and password.'
        redirect_to root_path
      elsif @role == 'admin'
        redirect_to root_path
      end
    else
      if @role == 'parent'
        render :parent
      elsif @role == 'organiser'
        render :organiser
      elsif @role == 'child'
        render :child
      elsif @role == 'admin'
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
