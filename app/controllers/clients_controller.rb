class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  def create
    if params[phones].present
      @client = Client.create!(client_params)
      params[phones].each do | k, v |
        Phone.create!(number: v, client_id: @client.id)        
      end   
      render json: {@client, status: :created, location: @client}         
    end
  end

  # GET /clients
  def index
    @clients = Client.all

    render json: @clients
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.permit(:ci, :name, :ivatype_id, :email)
    end
end
