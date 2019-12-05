class SoldsController < ApplicationController
  before_action :set_sold, only: [:show, :update, :destroy]

  # GET /solds
  def index
    @solds = Sold.all

    render json: @solds
  end

  # GET /solds/1
  def show
    render json: @sold
  end

  # POST /solds
  def create
    @sold = Sold.new(sold_params)

    if @sold.save
      render json: @sold, status: :created, location: @sold
    else
      render json: @sold.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /solds/1
  def update
    if @sold.update(sold_params)
      render json: @sold
    else
      render json: @sold.errors, status: :unprocessable_entity
    end
  end

  # DELETE /solds/1
  def destroy
    @sold.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sold
      @sold = Sold.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sold_params
      params.permit(:sell_id, :item_id, :price)
    end
end
