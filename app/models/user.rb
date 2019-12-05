class User < ApplicationRecord

	def self.getUser(uname)
  	@connection = ActiveRecord::Base.connection
  	result = @connection.exec_query("SELECT * FROM users WHERE username='#{uname}'")
  	return result
	end

end
