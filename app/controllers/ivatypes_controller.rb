class IvatypesController < ApplicationController
  before_action :set_ivatype, only: [:show, :update, :destroy]

  # GET /ivatypes
  def index
    @ivatypes = Ivatype.all

    render json: @ivatypes
  end

  # GET /ivatypes/1
  def show
    render json: @ivatype
  end

  # POST /ivatypes
  def create
    @ivatype = Ivatype.new(ivatype_params)

    if @ivatype.save
      render json: @ivatype, status: :created, location: @ivatype
    else
      render json: @ivatype.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ivatypes/1
  def update
    if @ivatype.update(ivatype_params)
      render json: @ivatype
    else
      render json: @ivatype.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ivatypes/1
  def destroy
    @ivatype.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ivatype
      @ivatype = Ivatype.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ivatype_params
      params.permit(:description)
    end
end
