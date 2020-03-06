class Api::V1::BabiesController  < ApplicationController
  before_action :set_baby, only: [:show, :update, :show, :destroy, :activity_logs]
  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_server_error
  end
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :not_found
  end
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  def activity_logs
    @activity_logs = @baby.activity_logs.paginate(:page => @page, :per_page => @limit)
    render json: @activity_logs, status: :ok
  end
  def index
    @babies = Baby.paginate(:page => @page, :per_page => @limit)
    render json: @babies, status: :ok
  end
  def create
    @baby = Baby.create!(create_params)
    render json: @baby, status: :created
  end
  def show
    render json: @baby, status: :ok
  end
  def update
    @baby.update!(update_params)
    render json: @baby, status: :ok
  end
  private
  def create_params
    params.require(:baby).permit(:name, :description, :birthday, :mother_name, :father_name, :address, :phone)
  end
  def update_params
    params.require(:baby).permit(:name, :description, :birthday, :mother_name, :father_name, :address, :phone)
  end
  def set_baby
    @baby = Baby.find(params[:id])
  end
end