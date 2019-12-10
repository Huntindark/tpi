require 'rails_helper'

RSpec.describe SellsController, type: :controller do
	describe 'post sell' do
		let(:token){create(:token)}	
		let(:client){create(:client)}
		let(:product){create(:product)}
		let!(:item){create(:item, product: product)}
		let(:sell)do
			{
				product.unicode.to_s => "1"
			}
		end
		context 'The sale is created succesfully' do
			let(:params)do
				{
					client_id: client.id,
					authentication: token.authentication,
					to_sell: sell
				}
			end
			subject { post :sell, params: params}
			it 'creates the sale' do
				expect{subject}.to change { Sell.count }.by(1)
			end
			it 'creates the solds' do
				expect{subject}.to change {Sold.count}.by(1)
			end
			it 'changes items statuses' do
				expect{subject}.to change { item.reload.status }.from('Disponible').to('Vendido')
			end
		end
		context "The sale isn't created succesfully" do
			let(:params)do
				{
					client_id: client.id,
					to_sell: sell
				}
			end
			it "Doesn't creates the sale" do
				expect { subject }.to change { Sell.count }.by(0)
			end
			it "Doesn't creates the solds" do
				expect { subject }.to change { Sold.count }.by(0)
			end
			it "Doesn't changes the Item statuses" do
				expect{subject}.not_to change { item.reload.status }.from('Disponible')
			end
		end
	end
end