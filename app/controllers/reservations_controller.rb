class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def not_sold
    query = Reservation.notSold
    render json: query
  end

  def by_id
    res = {}
    res['Reserva'] = Reservation.findById(params[:id])
    if params[:items].present? 
      res['Items'] = Reserved.itemsFor(params[:id])
    end
    if params[:sale].present? 
      res['Venta'] = Sell.saleFor(params[:id])
    end 

    render json: res

  end


  # GET /reservations
  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.permit(:client_id, :user_id, :status, :items, :sale)
    end
end
