class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def list_filtered
#    if params[:token].present? && params[:token] == session[:token] && params[:q].present?
    if params[:q].present?
      filter = params[:q]
      query = {}
      @products = Product.all
      if filter == 'scarce'
        @products.map do |product|
          query[product.name] = Product.getScarce(product)
        end
      end
      render json: query
    end
  end


  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.permit(:uniCode, :desc, :detail, :basePrice, :q, :token, :name)
    end
end
