class ConvocationsController < ApplicationController
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

  # DELETE /convocations/1
  def destroy
    @convocation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_convocation
      @convocation = Convocation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def convocation_params
      params.require(:convocation).permit(:name, :description, :type_student, :end_date, :admin_id, :vacants, :hours_per_week, :payout, :duration)
    end
end
