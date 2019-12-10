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


=begin			
		it 'creates the reserveds' do
			expect{subject}.to change {Reserved.count}.by(1)
		end
		it 'changes items statuses' do
			expect{subject}.to change { item.reload.status }.from('Disponible').to('Reservado')
		end
=end		
=begin
		context "The reservation isn't created succesfully" do
			let(:params)do
				{
					client_id: client.id,
					to_reserve: res
				}
			end
			it "Doesn't creates the reservation" do
				expect { subject }.to change { Reservation.count }.by(0)
			end
			it "Doesn't creates the reserveds" do
				expect { subject }.to change { Reserved.count }.by(0)
			end
			it "Doesn't changes the Item statuses" do
				expect{subject}.not_to change { item.reload.status }.from('Disponible')
			end
		end
	end
=end
=begin	describe 'get list_filtered' do
		context 'The products are listed succesfully' do
			let!(:token){create(:token)}
			let(:client){create(:client)}
			let(:product){create(:product)}
			let!(:items){create_list(:item, 8, product: product)}			
			let(:stock)do
				{
					q: 'in_stock',
					authentication: token.authentication
				}
			end
			let(:scarce)do
				{
					q: 'scarce',
					authentication: token.authentication
				}
			end
			let(:all)do
				{
					q: 'all',
					authentication: token.authentication
				}
			end
			let(:none)do
				{
					authentication: token.authentication
				}
			end
			it 'lists products in stock' do
				subject = {get :list_filtered, params: stock}
				subject
				expect(assigns(:items).map(item.product.unicode.to_sym)).to eq 8
			end
		end
	end
=end