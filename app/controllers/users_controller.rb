require 'digest/sha1'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def session
    @user = User.find_by(username: params[:username], passwd: params[:passwd])  
    if @user.present?
      expiration = Time.now.utc + 30.minutes
      authentication =  Digest::SHA1.hexdigest "#{@user.id}#{@user[:passwd]}#{@user[:username]}#{expiration}"
      token = Token.new(user_id: @user[:id], authentication: authentication, created_at: Time.now.utc, updated_at: Time.now.utc)
      token.save
      render json: { authentication: token.authentication }
    else 
      render json: status: 406
    end
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
    if @user.username != ''
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique => e 
    render json: e
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique => e
    render json: e
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
