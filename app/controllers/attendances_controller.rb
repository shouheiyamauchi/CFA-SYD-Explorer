class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.user_id = current_user.id
    @event = Event.find(params[:id])
    @attendance.event_id = @event.id
    if current_user.autoapprove == "true"
      @attendance.attendance_status = "approved"
    else
      @attendance.attendance_status = "pending"
    end

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @event, notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attend_event
    @user_location = [params[:latitude], params[:longitude]]
    @event_location = [Event.find(params[:event_id]).latitude, Event.find(params[:event_id]).longitude]
    @distance = Geocoder::Calculations.distance_between(@user_location, @event_location, :units => :km)

    if @distance < 5
      Attendance.find(params[:attendance_id]).update_attribute :attendance_status, "attended"
      flash[:success] = 'You have successfully checked in. Enjoy the event!'
      redirect_to root_path
    else
      flash[:danger] = 'You cannot check in as you are not at the event location.'
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      # params.require(:attendance).permit(:user_id, :event_id, :attendance_status)
    end
end
