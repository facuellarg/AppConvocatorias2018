class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /applications
  def index
    
    @applications = current_user.applications.map { |x| x.convocation.as_json.merge(state: x.state) }

    render json: @applications
  end

  # GET /applications/1
  def show
    render json: @application
  end

  # POST /applications
  def create
    self_params = application_params
    
    @application = Application.new(application_params)
    current_user.applications << @application
    if @application.save
      render json: @application, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /applications/1
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.permit(:convocation_id,:state)
    end
end
