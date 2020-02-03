class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  def create
    @client = Client.new(client_params)
    if params[:phones].present?
      params[:phones].split(',').each do | k |
        @client.phones.build(number: k)
      end
    end
    if @client.save
      render json: @client, status: :created, location: @client          
    else
      render json: @client.errors, status: :bad_request
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
