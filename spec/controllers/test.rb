require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
	describe 'put sell' do
		let(:token){create(:token)}
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