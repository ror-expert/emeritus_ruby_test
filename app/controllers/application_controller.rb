class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def set_course
    @course = Course.find params[:course_id] if current_user.admin?
    @course ||= Course.where(school_id: current_user.schools.ids).find params[:course_id]
  end

end
