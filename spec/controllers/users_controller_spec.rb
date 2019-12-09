require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe 'post usuarios' do
		context 'succesful creation' do
            let(:params) do
                {
                    username: 'Joe',
                    passwd: '1234'
                }
            end
            it 'succeds' do
                expect { post :create, params: params }.to change { User.count }.by(1)
            end
        end

        context 'failed creation' do
            let(:params) do
                {
                    username: 'Joe',
                    passwd: ''
                }
            end            
            it 'fails' do
                expect { post :create, params: params }.to change { User.count }.by(0)
            end
        end


	end
end
