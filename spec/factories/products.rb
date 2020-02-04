FactoryBot.define do
	factory :product do
		unicode {"abc" + rand(10 ** 6).to_s.rjust(6,'0')}
		desc {"sdfghjklñqwertyuiop"}
		detail {"34567890ertyuiop"}
		basePrice {1234}
		
		factory :itemized_product do
			transient do 
				cant_items {6}
			end

			after(:create) do | product, evaluator |
				create_list( :item, evaluator.cant_items, product: product )
			end
		end
	end

end