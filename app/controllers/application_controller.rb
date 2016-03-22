class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:error] = 'Error 404: Record Not Found'
    redirect_to root_url
  end

  rescue_from ActionController::ParameterMissing do |exception|
    flash[:error] = exception.message
    redirect_to new_polymorphic_url(controller_name.singularize.to_sym)
  end
  
  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      dashboards_path(anchor: 'login-success')
    end
  end

end
