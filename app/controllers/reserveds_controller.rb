class ReservedsController < ApplicationController
  before_action :set_reserved, only: [:show, :update, :destroy]

  # GET /reserveds
  def index
    @reserveds = Reserved.all

    render json: @reserveds
  end

  # GET /reserveds/1
  def show
    render json: @reserved
  end

  # POST /reserveds
  def create
    @reserved = Reserved.new(reserved_params)

    if @reserved.save
      render json: @reserved, status: :created, location: @reserved
    else
      render json: @reserved.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reserveds/1
  def update
    if @reserved.update(reserved_params)
      render json: @reserved
    else
      render json: @reserved.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reserveds/1
  def destroy
    @reserved.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserved
      @reserved = Reserved.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reserved_params
      params.permit(:reservation_id, :item_id, :price)
    end
end
