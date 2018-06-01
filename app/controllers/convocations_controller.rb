class ConvocationsController < ApplicationController
  before_action :authenticate_user, only: [:search]
  before_action :authenticate_admin, only: [:create,:admin_convocations,:show_admin,:most_wanted]

  before_action :set_convocation, only: [:show, :update, :destroy,:show_admin]

  # GET /convocations
  def index
    @convocations = Convocation.all

    render json: @convocations
  end
  def show_admin
    #render json: @convocation
    respond_to do |format|
      format.json {render   json: @convocation.populate_for_admin}
      format.pdf {render template: 'convocations/template_pdf',pdf: @convocation.name.downcase}
      format.any {render   json: @convocation.populate_for_admin}
    end
  end
  # GET /convocations/1
  def show
    #render json: @convocation
    respond_to do |format|
      format.json {render   json: @convocation}
      format.pdf {render template: 'convocations/template_pdf', pdf: @convocation.name.downcase}
      format.any {render   json: @convocation}
    end
  end
  def admin_convocations
    puts params
    puts 'sndkjasndfkasdnfjkansdfkjnasdn'
    puts current_admin.convocations.as_json
    render json: current_admin.convocations.as_json, status: 200
  end
  # POST /convocations
  def create
    puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    puts params.as_json
    puts 'ssssssssssssssssssssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    #return
    self_params = convocation_params.as_json
    self_params[:admin_id] = current_admin.id
    convocation_params[:admin_id] = current_admin.id
    @convocation = Convocation.new(self_params)

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
    #aux_array = []
    self_params = search_params
    out_object = {}
  
    #aux_array.push(self_params[:dependence] || current_user.dependence_id)
    if self_params[:dependence]
      self_params[:dependences] = []
      self_params[:dependences].push(self_params[:dependence])
    end
    #self_params[:dependences] = aux_array
    search_convocatories = Convocation.search(self_params)
    puts 'Convocationssssssssss  -------------'
    puts search_convocatories
    puts 'asdfasldfjaksdjflkasjdflkasjdklfjasldfjalskjdflasjfkalsjdflakjsdflakjsdlfjaslkdjfl'
    out_object[:convocations] = search_convocatories.paginate(:page => self_params[:page] || 1,:per_page => 10).map{ |x| x.populate }
    out_object[:pages] = (search_convocatories.count / 10.0).ceil
    
    render json: out_object
  end
  def most_wanted
    render json: Convocation.most_wanted, status: 200
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
      #params.permit(:name, :description, :level, :end_date, :vacants, :hours_per_week, :payout, :duration,:requirements => [],:dependences => [],:profiles => [],:activities => [],:required_files => [])
      params.permit(:name, :description, :level, :end_date, :vacants, :hours_per_week, :payout, :duration,
        {:requirements_attributes=> [:description]},{:profiles_attributes=> [:description]},{:activities_attributes=> [:description]},
          {:required_files_attributes=> [:name]},{:convocation_dependences_attributes=> [:dependence_id]})

    end
end
