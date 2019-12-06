require 'digest/sha1'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # POST /sesiones
  def login
    query = User.getUser(params[:u])
    if params[:p].present? && query[0]['passwd'] == params[:p] 
      session[:id] = query[0]['id'] 
      session[:expire] = Time.now.strftime("%H%M").to_i+30
      session[:token] = Digest::SHA1.hexdigest "#{session[:id]}#{params[:p]}#{params[:u]}#{session[:expire]}"
      render json: session
    else
      render json: "#{params[:p].present?} #{params[:u].present?}"
    end
  end

  def test
    render json: session
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :passwd, :u, :p)
    end
end
