class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :auth, only: [:index, :show, :create, :sell, :destroy]

  def index
    query = Reservation.not_sold
    render json: query
  end

  def show
    res = {}
    res['Reserva'] = Reservation.find(params[:id])
    if res['Reserva'].blank?  
      res['Items'] = Reserved.joins(:reservation, :item).joins("INNER JOIN products ON items.product_id = products.id").select('items.*') if params[:items].present?
      if params[:sale].present? && res['Reserva'].present?
        res['Venta'] =  Sell.joins(:reservation, :client, :user).select(:name, :username, :reservation_id, :created_at)
      end
      render json: res
    else 
      render json: {status: 404}
    end
  end  

  def create
    if params[:client_id].present? && params[:to_reserve].present?
      response = Reservation.reserve(params, @user)
      render json: response
    else 
      render json: {message: 'Missing parameters', status: 406 }
    end
  end
    
  def sell 
    res = Reservation.find(params[:id])
    if res.present?
      if res.status == 'Pendiente'
        sale = Reservation.sell(res, @user)
        ans = sale
      else
        ans =  {message: 'Reservation already sold', status: 406 }  
      end
    else
      ans = {message: 'Reservation not found', status: 404 }
    end
    render json:{ venta: ans}
  end

  def destroy
    res = Reservation.find(params[:id])
    if res.present? && (res.status != 'Vendido')
      toFree = Reserved.where(reservation_id: res.id)
      toFree.map { |free| Item.find(free.item_id).update!(status: 'Disponible') }
      res.update!(status: 'Cancelada')
    end
  end

  # GET /reservations
=begin
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

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end
=end


  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
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