class StudentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_course
  before_action :set_batch

  # GET /students or /students.json
  def index
    @students = @batch.students
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params.merge!(school_id: set_school.id))

    respond_to do |format|
      if @student.valid? && @student.created? && @student.batch_enrolled?(@batch)
        format.html { redirect_to course_batch_students_url(@course, @batch), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    batch_user = @batch.batch_users.where(user_id: set_student.id).first
    batch_user.accept!
    redirect_to course_batch_students_url(@course, @batch)
  end

  def reject
    batch_user = @batch.batch_users.where(user_id: set_student.id).first
    batch_user.reject!
    redirect_to course_batch_students_url(@course, @batch)
  end

  def enrollment
    batch_user = @batch.batch_users.create!(user_id: set_student.id)
    redirect_to course_batches_url(@course)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch ||= @course.batches.find(params[:batch_id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :email)
    end

    def set_school
      @school ||= set_course.school
    end

    def set_student
      @student = current_user if current_user.student?
      @student ||= set_batch.students.find params[:student_id]
    end
end
