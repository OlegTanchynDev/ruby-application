# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale
  layout(proc {
    if current_user&.role == "Administrator"
      'admin'
    else
      'application'
    end
  })

  def set_locale
    if current_user
      I18n.locale = current_user.locale ? current_user.locale : I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end

  include Pagy::Backend
  protect_from_forgery prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end
end
