class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def list_filtered
#    if params[:token].present? && params[:token] == session[:token] && params[:q].present?
    @products = Product.all
    if params[:q].present?
      filter = params[:q]
      query = {}
      if filter == 'scarce'
          query = Product.getScarce(@products)
      elsif filter == 'all'
          query = Product.getAll(@products)
      end
    else 
      query = Product.getInStock(@products)
    end
    render json: query.first(25)
  end

  def show_prod
    product = Product.getProdByCode(params[:code])
#    render json: product.blank? ?  404 : product
    if product.blank?
      render status: 404 
    else
      render json: product
    end
  end

  def show_prod_items
    product = Product.getProdByCode(params[:code]) 
    if product.blank?
      render status: 404 
    else
      items = Product.getProdItems(product)
      render json: items
    end
  end

  def create_prod_items
    if params[:create_x].present?
      create = params[:create_x]
      product = Product.getProdByCode(params[:code]) 
      create.to_i.times {Item.create_for(product)}
    else
      render status: 406
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
      params.permit(:uniCode, :desc, :detail, :basePrice, :q, :token, :name, :create_x)
    end
end
