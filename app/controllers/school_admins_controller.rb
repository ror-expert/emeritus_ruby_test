class SchoolAdminsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource class: 'User'
  before_action :school_data, except: :index

  def index
    @school_admins = User.school_admins
  end

  def new
    @school_admin = SchoolAdmin.new
  end

  def create
    @school_admin = SchoolAdmin.new(school_admin_params)

    respond_to do |format|
      if @school_admin.valid? && @school_admin.created?
        format.html { redirect_to school_admins_path, notice: "School Admin was successfully created & enrolled in batch." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @school_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def school_admin_params
    params.require(:school_admin).permit(:first_name, :last_name, :email, :school_id)
  end

  def school_data
    @schools ||= School.select(:id, :name).collect { |school| [ school.name, school.id ] }
  end
end
