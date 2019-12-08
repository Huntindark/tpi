class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def not_sold
    query = Reservation.notSold
    render json: query
  end

  def by_id
    res = {}
    res['Reserva'] = Reservation.findById(params[:id])
    if res['Reserva'].blank?
      res['Items'] = Reserved.itemsFor(params[:id]) if params[:items].present?       
      res['Venta'] = Sell.saleFor(params[:id]) if params[:sale].present?
      render json: res
    else 
      render status: 404
    end
  end

  def reserve
    if params[:client_id].preset? && params[:user_id].preset? && params[:to_reserve].preset?
      client = params[:client_id]
      user = params[:user_id]
      reserve =  params[:to_reserve]
      response = Reservation.reserve(client, user, reserve)
      render json: response
    else 
      render json: {message: 'Missing parameters', status: 406 }
    end
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
    params.permit(:client_id, :user_id, :status, :items, :sale, :to_reserve)
  end
end
