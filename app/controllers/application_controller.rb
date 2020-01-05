class ApplicationController < ActionController::API
    def auth 
      user = Token.authenticate(params[:authentication])
      render status: 401 if !user.present? 
    end
end
