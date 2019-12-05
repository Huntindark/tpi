class SellsController < ApplicationController
  before_action :set_sell, only: [:show, :update, :destroy]

  # GET /sells
  def index
    @sells = Sell.all

    render json: @sells
  end

  # GET /sells/1
  def show
    render json: @sell
  end

  # POST /sells
  def create
    @sell = Sell.new(sell_params)

    if @sell.save
      render json: @sell, status: :created, location: @sell
    else
      render json: @sell.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sells/1
  def update
    if @sell.update(sell_params)
      render json: @sell
    else
      render json: @sell.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sells/1
  def destroy
    @sell.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell
      @sell = Sell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sell_params
      params.permit(:client_id, :user_id, :reservation_id)
    end
end
