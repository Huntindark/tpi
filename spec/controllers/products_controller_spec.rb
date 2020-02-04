require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
	let(:token){create(:token)}		
	describe 'post create_prod_items' do
		let!(:product){create(:product)}
		context 'The product items are created' do
			let(:params) do
				{
					authentication: token.authentication,
					id: product.unicode,
					create_x: '2'
				}
			end
			it 'succeds creating items' do
				expect { post :create_prod_items, params: params }.to change { Item.count }.by(2)
			end
		end
		context 'The product items are not created' do
			let(:params) do
				{
					authentication: token.authentication,
					id: product.unicode
				}
			end
			it "doesn't creates items" do
				expect { post :create_prod_items, params: params }.not_to change { Item.count }			
			end
		end
	end

	describe 'get index' do
		context 'q param set as all' do
			let!(:products){create_list(:itemized_product, 3)}
			let(:params) do
				{
					authentication: token.authentication,
					q: 'all'
				}
			end
			it 'lists correctly' do
				get :index, params: params
				expect(assigns(:query).length).to eq products.size
			end
		end

		context 'q param not set' do
			let!(:products){create_list(:itemized_product, 3)}
			let(:params) do
				{
					authentication: token.authentication
				}
			end
			it 'lists correctly' do
				get :index, params: params
				expect(assigns(:query).length).to eq products.size
			end
		end

		context 'q param set as scarce' do
			let!(:products){create_list(:itemized_product, 3)}
			let(:params) do
				{
					authentication: token.authentication,
					q: 'scarce'				
				}
			end
			it 'lists correctly' do
				get :index, params: params
				expect(assigns(:query).length).to eq 0
			end
		end
	end

	describe 'get show_prod_items' do
		let!(:product){create(:itemized_product)}
		let(:params) do
			{
				authentication: token.authentication,
				id: product.unicode
			}
			end
		it 'lists all the items' do
		 	get :show_prod_items, params: params
		 	expect(assigns(:items).length).to eq product.items.size
			expect(assigns(:items).map(&:id)).to eq product.items.map(&:id)
		end
	end

	describe 'get show' do
		let!(:product){create(:itemized_product)}
		let(:params) do
			{
				authentication: token.authentication,
				id: product.unicode
			}
			end
		it 'shows prod info' do
		 	get :show, params: params
		 	expect(assigns(:product)).to eq product
		end
	end

	describe 'post create' do
		context 'products with valid atributes' do
			let(:atributes) do
			 	{
					unicode: 'abc123456',
					desc: 'Un string',
					detail: 'Hola mili',
					basePrice: 99,
					name: 'Mili'
				}
			end
			it 'creates the product' do
				expect { post :create, params: {authentication: token.authentication, product: atributes}}.to change {Product.count}.by(1)

			end
		end
		context 'products with invalid atributes' do
			let(:atributes) do
			 	{
					unicode: 'ab56',
					desc: 'Un string',
					detail: 'Hola mili',
					basePrice: 99,
					name: 'Mili'
				}
			end
			it 'doesnt creates the product' do
				expect { post :create, params: {authentication: token.authentication, product: atributes}}.not_to change {Product.count}				
				expect(assigns(:product).errors[:unicode]).to include('Se requiere que el formato sea de 3 letras y 6 numeros') 
			end
		end
	end


end