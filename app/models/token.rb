class Token < ApplicationRecord
  belongs_to :user

  def self.authenticate(auth)
  	token = Token.find_by(authentication: auth)
  	if token.created_at < (Time.now.utc + 30.minutes)
  		user = User.find(token.user_id)
  		return user
  	end
  end


end
