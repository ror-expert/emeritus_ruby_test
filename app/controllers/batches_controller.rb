class BatchesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :classmates

  before_action :set_course
  before_action :set_batch, only: %i[ show edit update destroy classmates]

  # GET /batches or /batches.json
  def index
    @batches = @course.batches
  end

  # GET /batches/1 or /batches/1.json
  def show
    @students = @batch.students 
  end

  # GET /batches/new
  def new
    @batch = Batch.new
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches or /batches.json
  def create
    @batch = @course.batches.new(batch_params)

    respond_to do |format|
      if @batch.save
        format.html { redirect_to course_batches_url(@course), notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to course_batch_url(@course, @batch), notice: "Batch was successfully updated." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to course_batches_url(@course), notice: "Batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def classmates
    @students = set_batch.students
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = @course.batches.find(params[:id] || params[:batch_id])
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:name)
    end

    def set_course
      @course = Course.find params[:course_id] if current_user.admin?
      @course ||= Course.where(school_id: current_user.schools.ids).find params[:course_id]
    end
end
