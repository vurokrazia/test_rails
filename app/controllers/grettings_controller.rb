class GrettingsController < ApplicationController
  def index
    render json: {message: t('hello')}, status: :ok
  end
end
