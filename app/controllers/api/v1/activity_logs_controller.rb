class Api::V1::ActivityLogsController  < ApplicationController
  before_action :set_activity_log, only: [:show, :update, :show, :destroy]
  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_server_error
  end
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :not_found
  end
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  def index
    @activity_logs = ActivityLog.all
    render json: @activity_logs, status: :ok
  end
  def create
    @activity_log = ActivityLog.create!(create_params)
    render json: @activity_log, status: :created
  end
  def show
    render json: @activity_log, status: :ok
  end
  def update
    @activity_log.update!(update_params)
    render json: @activity_log, status: :ok
  end
  private
  def create_params
    params.require(:activity_log).permit(:baby_id,:assistant_id,:activity_id,:start_time,:stop_time,:duration,:comments)
  end
  def update_params
    params.require(:activity_log).permit(:start_time,:stop_time,:duration,:comments)
  end
  def set_activity_log
    @activity_log = ActivityLog.find(params[:id])
  end
end