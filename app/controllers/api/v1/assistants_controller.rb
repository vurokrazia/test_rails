class Api::V1::AssistantsController  < ApplicationController
  before_action :set_assistant, only: [:show, :update, :show, :destroy]
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
    @assistants = Assistant.paginate(:page => @page, :per_page => @limit)
    render json: @assistants, status: :ok
  end
  def create
    @assistant = Assistant.create!(create_params)
    render json: @assistant, status: :created
  end
  def show
    render json: @assistant, status: :ok
  end
  def update
    @assistant.update!(update_params)
    render json: @assistant, status: :ok
  end
  private
  def create_params
    params.require(:assistant).permit(:name, :group,  :address, :phone)
  end
  def update_params
    params.require(:assistant).permit(:name, :group,  :address, :phone)
  end
  def set_assistant
    @assistant = Assistant.find(params[:id])
  end
end