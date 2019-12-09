class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def list_filtered
    user = Token.authenticate(params[:authentication])
    if user.present?
      @products = Product.all
      if params[:q].present?
        filter = params[:q]
        query = {}
        if filter == 'scarce'
            query = Product.getScarce
        elsif filter == 'all'
            query = Product.getAll
        end
      else 
        query = Product.getInStock
      end
      render json: query.first(25)
    else
      render status: 404
    end
  end



  def show_prod
    user = Token.authenticate(params[:authentication])
    if user.present?
      product = Product.find_by(unicode: params[:code])
      if product.blank?
        render status: 404 
      else
        render json: product
      end
    else
      render status: 404
    end
  end

  def show_prod_items
    user = Token.authenticate(params[:authentication])
    if user.present?
      product = Product.find_by(unicode: params[:code]) 
      if product.blank?
        render status: 404 
      else
        items = Item.where(product_id: product.id)
        render json: items
      end
    else 
      render status: 404
    end
  end

  def create_prod_items
    user = Token.authenticate(params[:authentication])
    if user.present?    
      if params[:create_x].present?
        create = params[:create_x]
        product = Product.find_by(unicode: params[:code]) 
        Product.createItems(product.id, create)   
      else
        render status: 406
      end
    else
      render status: 404
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
      params.permit(:unicode, :desc, :detail, :basePrice, :q, :token, :name, :create_x)
    end
end
