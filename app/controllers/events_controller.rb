class EventsController < ApplicationController
  before_action :enable_header
  before_action :enable_navbar
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :limit_events_index, only: [:index]
  before_action :limit_event_show, only: [:show]

  # GET /events
  # GET /events.json
  def index
    @attendance_ids = Array.new
    if current_user.role == "parent"
      @children = User.where(parent_id:current_user.id)
      @children.each do |child|
        child.attendances.pending.each do |attendance|
          @attendance_ids << attendance.id
        end
      end
    end

    @organiser_events = Event.owner(current_user)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @attendance = Attendance.new
    @attendances = @event.attendances
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    if current_user.role == "organiser"
      @event.event_approved = "false"
    elsif current_user.role == "admin"
      @event.event_approved = "true"
    end
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    Event.find(params[:event_id]).update_attribute :event_approved, "true"
    flash[:success] = 'The event has been approved.'
    redirect_to events_path
  end

  def reject
    Event.find(params[:event_id]).update_attribute :event_approved, "rejected"
    flash[:danger] = 'The event has been rejected.'
    redirect_to events_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Limit children and parents to only see a list of approved events
    def limit_events_index
      if current_user.role == "parent" || current_user.role == "child" || current_user.role == "organiser"
        @events = Event.approved
      else
        @events = Event.everything
      end
    end

    # Disable children and parents from seeing a pending event
    def limit_event_show
      if current_user.role == "administrator"
      elsif @event.user_id == current_user.id
      elsif @event.event_approved == "false"
        flash[:danger] = 'You cannot view an unapproved event.'
        redirect_to events_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_name, :event_description, :event_location, :event_cost, :event_date, :event_approved, :event_category)
    end
end
