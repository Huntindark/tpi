class ApplicationController < ActionController::API
    def auth 
      @user = Token.authenticate(params[:authentication])
      render json: {status: 401} unless @user.present? 
    end
end
