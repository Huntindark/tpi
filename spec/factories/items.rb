FactoryBot.define do
	factory :item do
		association :product
		available

		trait :reserved do
			status {'Reservado'}
		end
		trait :available do
			status {'Disponible'}
		end
	end
end