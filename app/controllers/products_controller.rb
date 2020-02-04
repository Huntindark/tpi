class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :show_prod_items, :update, :destroy, :create_prod_items]
  before_action :auth, only: [:show, :index, :show_prod_items, :create_prod_items]


  def index
    products = Product.all
    if params[:q].present?
      filter = params[:q]
      @query = {}
      if filter == 'scarce'
          @query = Product.getScarce
      elsif filter == 'all'
          @query = Product.getAll
      end
    end
    @query = Product.getInStock unless @query
    render json: {productos: @query.first(25)}
  end

  def show
    render json: @product
  end

  def show_prod_items
    @items = Item.where(product_id: @product.id)
    render json: {items: @items}
  end

  def create_prod_items
    if params[:create_x].present?
      create = params[:create_x]
      Product.createItems(@product.id, create)   
    else
      render json: {status: 406}
    end
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
      @product = Product.find_by(unicode: params[:id]) 
      if @product.blank?
        render json: {status: 404}
      end
    end



    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:unicode, :desc, :detail, :basePrice, :name)
    end
end
