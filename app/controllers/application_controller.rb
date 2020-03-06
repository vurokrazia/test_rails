class ApplicationController < ActionController::Base
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    @limit      = params[:max_results] || 15 
    @page       = params[:page] || 1
  end
  def default_url_options
    { locale: I18n.locale }
  end
  def authenticate_editor!
    redirect_to new_user_session_path,notice: "No tienes permisos para esta acción" unless user_signed_in? && current_user.is_editor?
  end
  def authenticate_admin!
    redirect_to new_user_session_path,notice: "No tienes permisos para esta acción" unless user_signed_in? && current_user.is_admin?
  end
end