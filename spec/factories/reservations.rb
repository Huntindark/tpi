FactoryBot.define do
	factory :reservation do
		association :client
		association :user
		status {'Pendiente'}
	end
end