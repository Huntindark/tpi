class Token < ApplicationRecord
  belongs_to :user

  def self.authenticate(auth)
  	token = Token.find_by(authentication: auth)
  	if token.present? 
  		if (token.created_at + 30.minutes) > (Time.now.utc)
  			user = User.find(token.user_id)
  		else
  			token.delete
  			false
  		end
  	else
  		false
  	end
  end


end
