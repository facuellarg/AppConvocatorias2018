class DocumentsController < ApplicationController

  before_action :authenticate_user, only: [:create, :index]
  before_action :authenticate_admin, only: [:admin_files]
  before_action :set_document, only: [:show, :update, :destroy]

  # GET /documents
  def index
    #puts 'sdgjhdksfhdhfjkhaskdhfksjhdkfhdkjhaskfjhk'
    #puts request.headers["Authorization"]
    @documents = []
    UserDocument.where(user_id: current_user.id).each do |doc|
      @documents.push(doc.document)
    end
    #@documents = UserDocument.where(user_id: current_user.id)
    #@documents = Document.all
    render json: @documents
  end

  # GET /documents/1
  def show
    render json: @document
  end

  # POST /documents
  def create
    
    @document = Document.new(document_params)
    current_user.documents << @document
    if @document.save!
      UserDocument.create!(user_id: current_user.id,document_id: @document.id)
      
      render json: @document, status: :created, location: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /documents/1
  def update
    if @document.update(document_params)
      render json: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end
  def admin_files
    current_docs = User.find_by(:id => admin_params[:user_id]).documents
    render json: current_docs, status: 200
  end
  # DELETE /documents/1
  def destroy
    @document.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def document_params
      params.permit(:file)
      #params.require(:document).permit(:address, :name, :type)
    end
    
    def admin_params
      params.permit(:user_id)
    end
end
