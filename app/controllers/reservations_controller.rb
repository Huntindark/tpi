class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :auth, only: [:not_sold, :by_id, :reserve, :sell, :cancel]

  def not_sold
    query = Reservation.not_sold
    render json: query
  end

  def by_id
    res = {}
    res['Reserva'] = Reservation.find(params[:id])
    if res['Reserva'].blank?  
      res['Items'] = Reserved.joins(:reservation, :item).joins("INNER JOIN products ON items.product_id = products.id").select('items.*') if params[:items].present?
      if params[:sale].present? && res['Reserva'].present?
        res['Venta'] =  Sell.joins(:reservation, :client, :user).select(:name, :username, :reservation_id, :created_at)
      end
      render json: res
    else 
      render status: 404
    end
  end  

  #curl -X POST ht":{"abc123456": "1"}}' -H "Content-Type:application/json"_id":"1", "to_reserve"    '{"client_id":"1", "user_id":"1", "to_reserve":{"abc123456": "1"}}'

  def reserve
    if params[:client_id].present? && params[:to_reserve].present?
      response = Reservation.reserve(params, user)
      render json: response
    else 
      render json: {message: 'Missing parameters', status: 406 }
    end
  end
    
  def sell 
    res = Reservation.find(params[:id])
    if res.present?
      if res.status == 'Pendiente'
        sale = Reservation.sell(res, user)
        ans = sale
      else
        ans =  {message: 'Reservation already sold', status: 406 }  
      end
    else
      ans = {message: 'Reservation not found', status: 404 }
    end
    render json: ans
  end

  def cancel
    res = Reservation.find(params[:id])
    if res.present? && (res.status != 'Vendido')
      toFree = Reserved.where(reservation_id: res.id)
      toFree.map { |free| Item.find(free.item_id).update!(status: 'Disponible') }
      res.update!(status: 'Cancelada')
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

  def auth 
    user = Token.authenticate(params[:authentication])
    render status: 401 if !user.present? 
  end

  # Only allow a trusted parameter "white list" through.
  def reservation_params
    params.permit(:client_id, :user_id, :status, :items, :sale, :to_reserve)
  end
end