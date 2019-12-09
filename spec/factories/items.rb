FactoryBot.define do
	factory :item do
		association :product
		status {'Disponible'}
	end
end