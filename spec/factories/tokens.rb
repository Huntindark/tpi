FactoryBot.define do
	factory :token do
		association :user
		authentication {"dsaljdfsjlkfgkjñfd"}
	end
end