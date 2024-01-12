require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe 'GET #new' do
    it 'assigns a new dog as @dog' do
      get :new
      expect(assigns(:dog)).to be_a_new(Dog)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Dog' do
        expect {
          post :create, params: { dog: { breed_name: 'husky' } }
        }.to change(Dog, :count).by(1)
      end
    end
  end
end
