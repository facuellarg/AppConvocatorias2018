class ApplicationsController < ApplicationController
  before_action :authenticate_user, only: [:create,:index]
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
    
    if not Application.where('applications.convocation_id = ? AND applications.user_id = ?',application_params[:convocation_id],current_user.id).blank?
      render json: 'Este usuario ya aplico anteriormente',status: 400
      return
    end
    @application = Application.new(application_params)
    @application.state = "interesado"
    current_user.applications << @application
    if @application.save
      render json: @application, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(state: application_params[:state])
      
      ApplicationMailer.change_state(@application).deliver_later
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
