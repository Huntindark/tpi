FactoryBot.define do
	factory :reserved do
		price {'10'}
		association :reservation
		association :item
	end
end