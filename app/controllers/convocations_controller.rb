class ConvocationsController < ApplicationController
  before_action :authenticate_user, only: [:search]
  
  before_action :set_convocation, only: [:show, :update, :destroy]

  # GET /convocations
  def index
    @convocations = Convocation.all

    render json: @convocations
  end

  # GET /convocations/1
  def show
    render json: @convocation
  end

  # POST /convocations
  def create
    @convocation = Convocation.new(convocation_params)

    if @convocation.save
      render json: @convocation, status: :created, location: @convocation
    else
      render json: @convocation.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /convocations/1
  def update
    if @convocation.update(convocation_params)
      render json: @convocation
    else
      render json: @convocation.errors, status: :unprocessable_entity
    end
  end

  def search
    aux_array = []
    self_params = search_params
    out_object = {}
    if self_params[:dependence]
      aux_array.push(self_params[:dependence])
    else
      aux_array.push(current_user.dependence_id)
    end
    self_params[:dependences] = aux_array
    out_object[:pages] = (Convocation.count / 10).floor
    out_object[:convocations] = Convocation.search(self_params).paginate(:page => self_params[:page] || 1,:per_page => 10).map{ |x| x.populate }
  
    render json: out_object
  end
  # DELETE /convocations/1
  def destroy
    @convocation.destroy
  end

  private
    def search_params
      params.permit(:page,:level,:dependence,:payout_min,:payout_max,:duration_min,:duration_max,:hours_per_week_min,:hours_per_week_max)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_convocation
      @convocation = Convocation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def convocation_params
      params.require(:convocation).permit(:name, :description, :type_student, :end_date, :admin_id, :vacants, :hours_per_week, :payout, :duration)
    end
end
