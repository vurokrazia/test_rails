class Api::V1::SessionsController < ApplicationController
  before_action :authenticate_user, except: [:create]
  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_server_error
  end
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :not_found
  end
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
  def create
    @user    = User.from_login(create_params)
    password = User.find_password(create_params)
    if @user && @user.valid_password?(password)
      @token = Token.create!(user_id: @user.id)
      render json: @token, status: :created
    else
      render json: {error: t('credentials.user_invalid')}, status: :bad_request
    end
  end
  private
  def create_params
    params.require(:user).permit(:email, :password)
  end
end