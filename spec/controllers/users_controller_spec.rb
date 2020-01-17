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
                    username: '',
                    passwd: '1234'
                }
            end            
            it 'fails' do
                expect { post :create, params: params }.to change { User.count }.by(0)
            end
        end
	end
    describe 'post session' do
        context 'succesful login' do
            let!(:user){create(:user)}
            let(:params) do
                {
                    username: 'Joe',
                    passwd: '1234'
                }
            end
            it 'logs in' do
                expect { post :session, params: params }.to change { Token.count }.by(1)
            end
        end
        context 'unsuccesful login' do
            let!(:user){create(:user)}
            let(:params) do
                {
                    username: 'John',
                    passwd: '1234'
                }
            end
            it "doesn't logs in" do
                expect { post :session, params: params }.to change { Token.count }.by(0)
            end
        end
    end
end
