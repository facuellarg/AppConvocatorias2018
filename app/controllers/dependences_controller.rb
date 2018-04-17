class DependencesController < ApplicationController

  # GET /dependences
  def index
    @dependences = Dependence.all

    render json: @dependences
  end

  private

    # Only allow a trusted parameter "white list" through.
    def dependence_params
      params.fetch(:dependence, {})
    end
end
