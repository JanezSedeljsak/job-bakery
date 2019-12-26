class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  # GET /jobs
  # GET /jobs.json
  def index
    if(request.GET[:filter])
        filter = request.GET[:filter]
        @jobs = Job.where('LOWER(title) LIKE ?', "%#{filter}%")
    elsif (request.GET[:o] && request.GET[:t])
        order = request.GET[:o]
        type = request.GET[:t]
        if order == 'alph'
            @jobs = Job.order(title: :"#{type}")
        else 
            @jobs = Job.order(created_at: :"#{type}")
        end
        
    else 
        @jobs = Job.all
    end

    @applied = []

    if user_signed_in?
        if(!current_user.company?)
            @applied = Candidate.where(user: current_user).select(:job_id).map { |n| n["job_id"] }
        end
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.user = current_user

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def applicants
    @job = Job.find(params[:id])
    @candidates = Candidate.where(job_id: params[:id])
    render :template => "jobs/_applicatns"
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully de_stroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:user_id, :title, :body, :location_id, :area_id, :attachment, :salary)
    end
end
