class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /jobs
  # GET /jobs.json
  def index
    @locations = Location.all
    @areas = Area.all

    # order filter renaming
    if request.GET['o']
        case request.GET['o']
        when "Date"    
            request.GET['o'] = "created_at"
        when "Alphabetical"    
            request.GET['o'] = "title"
        else
            request.GET['o'] = request.GET['o']
        end
    end

    @jobs = Job.where(nil)
    @jobs = @jobs.where('LOWER(title) LIKE ?', "%#{request.GET['f'].downcase}%") if request.GET["f"]
    @jobs = @jobs.order("#{request.GET['o'].downcase} #{request.GET['t']}") if request.GET["o"] && request.GET["t"] 
    @jobs = @jobs.where("salary >= ?", request.GET['s'].to_i) if request.GET["s"]
    
    if request.GET['a']
        @area_ = Area.where("title LIKE ? ", "%#{request.GET['a']}%").limit(1)[0]['id']
        @jobs = @jobs.where("area_id": @area_.to_i)
    end

    if request.GET['l']
        @location_ = Location.where("title LIKE ? ", "%#{request.GET['l']}%").limit(1)[0]['id']
        p @location_
        @jobs = @jobs.where("location_id": @location_.to_i)
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

    success = @job.save
    puts @job.id

    params["job"]["questions"].each do |item|
        @question = Question.new(:job_id => @job.id, :body => item)
        puts @question
        puts item
        @question.save
    end

    respond_to do |format|
      if success
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
      params.require(:job).permit(:user_id, :title, :body, :location_id, :area_id, :attachment, :salary, :questions)
    end
end
