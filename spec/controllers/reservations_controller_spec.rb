require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
	let(:token){create(:token)}	
	describe 'post reserve' do
		let(:client){create(:client)}
		let(:product){create(:product)}
		let!(:item){create(:item, product: product)}
		let(:res)do
			{
				product.unicode.to_s => "1"
			}
		end
		context 'The reservation is created succesfully' do
			let(:params)do
				{
					client_id: client.id,
					authentication: token.authentication,
					to_reserve: res
				}
			end
			subject { post :reserve, params: params}
			it 'creates the reservation' do
				expect{subject}.to change { Reservation.count }.by(1)
			end
			it 'creates the reserveds' do
				expect{subject}.to change {Reserved.count}.by(1)
			end
			it 'changes items statuses' do
				expect{subject}.to change { item.reload.status }.from('Disponible').to('Reservado')
			end
		end
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

	describe 'put sell' do
		#let(:token){create(:token)}
		let(:reservation){create(:reservation)}
		context 'The reservation is sold' do
			let(:params) do
				{
					authentication: token.authentication,
					id: reservation.id
				}
			end
			it 'Sells the reservation' do
				expect { put :sell, params: params }.to change { Sell.count }.by(1)
			end
			it 'changes reservation status' do
				expect { put :sell, params: params }.to change { reservation.reload.status }.from('Pendiendte').to('Vendido')
			end	
		end
		context 'The reservation is not sold' do
			let(:params) do
				{
					authentication: token.authentication,
					id: reservation.id
				}
			end
			it 'doesnt sells the reservation' do
				expect { put :sell, params: params}.to change { Sell.count }.by(0)
			end
		end
	end

end