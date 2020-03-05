class Api::V1::ActivitiesController  < ApplicationController
  before_action :set_activity, only: [:show, :update, :show, :destroy]
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
    @activities = Activity.paginate(:page => @page, :per_page => @limit)
    render json: @activities, status: :ok
  end
  def create
    @activity = Activity.create!(create_params)
    render json: @activity, status: :created
  end
  def show
    render json: @activity, status: :ok
  end
  def update
    @activity.update!(update_params)
    render json: @activity, status: :ok
  end
  private
  def create_params
    params.require(:activity).permit(:name, :description)
  end
  def update_params
    params.require(:activity).permit(:name, :description)
  end
  def set_activity
    @activity = Activity.find(params[:id])
  end
end