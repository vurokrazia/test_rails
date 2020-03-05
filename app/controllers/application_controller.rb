class ApplicationController < ActionController::Base
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    @limit      = params[:max_results] || 15 
    @page       = params[:page] || 1
  end
end