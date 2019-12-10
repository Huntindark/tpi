require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
	describe 'post create_prod_items' do
		context 'The product items are created' do
			let(:token){create(:token)}
			let!(:product){create(:product)}
			let(:params) do
				{
					authentication: token.authentication,
					code: product.unicode,
					create_x: '2'
				}
			end
			it 'succeds creating items' do
				expect { post :create_prod_items, params: params }.to change { Item.count }.by(2)
			end
		end
		context 'The product items are not created' do
		end
	end
end