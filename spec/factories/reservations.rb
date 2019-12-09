FactoryBot.define do
	factory :reservation do
		association :client
		association :user
		pending

		trait :sold do
			status {'Vendido'}
		end
		trait :pending do
			status {'Pendiente'}
		end
	end
end