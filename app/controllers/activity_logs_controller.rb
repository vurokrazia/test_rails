class ActivityLogsController < ApplicationController
  before_action :authenticate_editor!
  before_action :set_activity_log, only: [:show, :edit, :update, :destroy]

  # GET /activity_logs
  # GET /activity_logs.json
  def index
    hash = ActivityLogsSearchService.find_hash(params)
    @activity_logs = ActivityLog.paginate(:page => @page, :per_page => @limit).includes(:baby, :activity, :assistant)
    unless hash[:params].empty?
      @activity_logs = ActivityLogsSearchService.search(@activity_logs,hash)
      render json: @activity_logs, status: :ok
    else
      @baby = Baby.order_name_asc.collect {|p| [ "#{p.id} #{p.name}", p.id ] }
      @assistant = Assistant.order_name_asc.collect {|p| [ "#{p.id} #{p.name}", p.id ] }
      @activity = Activity.order_name_asc.collect {|p| [ "#{p.id} #{p.name}", p.id ] }
    end
    @search = true
  end

  # GET /activity_logs/1
  # GET /activity_logs/1.json
  def show
    
  end

  # GET /activity_logs/new
  def new
    @activity_log = ActivityLog.new
  end

  # GET /activity_logs/1/edit
  def edit
  end

  # POST /activity_logs
  # POST /activity_logs.json
  def create
    @activity_log = ActivityLog.new(create_params)

    respond_to do |format|
      if @activity_log.save
        format.html { redirect_to @activity_log, notice: 'Activity log was successfully created.' }
        format.json { render :show, status: :created, location: @activity_log }
      else
        format.html { render :new }
        format.json { render json: @activity_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_logs/1
  # PATCH/PUT /activity_logs/1.json
  def update
    respond_to do |format|
      if @activity_log.update(update_params)
        format.html { redirect_to @activity_log, notice: 'Activity log was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_log }
      else
        format.html { render :edit }
        format.json { render json: @activity_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_logs/1
  # DELETE /activity_logs/1.json
  def destroy
    @activity_log.destroy
    respond_to do |format|
      format.html { redirect_to activity_logs_url, notice: 'Activity log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_log
      @activity_log = ActivityLog.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def create_params
      params.require(:activity_log).permit(:baby_id, :assistant_id, :activity_id, :start_time, :stop_time, :duration, :comments, :status)
    end
    def update_params
      params.require(:activity_log).permit(:start_time,:stop_time,:duration,:comments,:status)
    end
end
