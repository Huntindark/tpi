require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
	describe 'post create' do
		let(:token){create(:token)}	
		let(:client){create(:client)}
		let(:product){create(:itemized_product)}
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
			subject { post :create, params: params}
			it 'creates the reservation' do
				expect{subject}.to change { Reservation.count }.by(1)
			end
			it 'creates the reserveds' do
				expect{subject}.to change {Reserved.count}.by(1)
			end
			it 'changes items statuses' do
				item_count = product.items.where(status: 'Disponible').count
				subject
				expect(product.items.where(status: 'Disponible').count).to eq item_count - 1
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
		let(:token){create(:token)}
		context 'The reservation is sold' do
			let(:reservation){create(:reservation, user: token.user, )}
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
				expect { put :sell, params: params }.to change { reservation.reload.status }.from('Pendiente').to('Vendido')
			end	
		end
		context 'The reservation is not sold' do
			let(:reservation){create(:reservation, :sold, user: token.user, )}
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

	describe 'delete destroy' do
		let(:token){create(:token)}
		context 'The reservation is deleted (logically)' do
			let(:reservation){create(:reservation, user: token.user, )}
			let(:item){create(:item, :reserved)}
			let(:reserved){create(:reserved, reservation:reservation, item: item)}
			let(:params) do
				{
					authentication: token.authentication,
					id: reservation.id
				}
			end
			it 'cancels the reservation' do
				expect { delete :destroy, params: params }.to change { reserved.reload.item.status }.from('Reservado').to('Disponible')
			end
			it 'changes reservation status' do
				expect { delete :destroy, params: params }.to change { reservation.reload.status }.from('Pendiente').to('Cancelada')
			end	
		end
	end

end