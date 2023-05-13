require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { first_name: 'John', last_name: 'Doe', email: 'john@example.com' } }

      it 'creates a new person' do
        expect do
          post :create, params: valid_params
        end.to change(Person, :count).by(1)
      end

      it 'redirects to the index page' do
        post :create, params: valid_params
        expect(response).to redirect_to(api_v1_people_path(Person.last))
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { first_name: '', last_name: '', email: 'john@example.com' } }
      it 'does not create a new person' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Person, :count)
      end
    end
  end

  describe 'PATCH #validate_email' do
    let!(:person) { Person.create(first_name: 'John', last_name: 'Doe', email: 'admin@gmail.com', validated: false) }
    let(:valid_params) { { slug: person.slug } }

    context 'when user is present' do
      it 'updates the user validation status' do
        patch :validate_email, params: valid_params
        person.reload
        expect(person.validated).to be true
      end
    end

    context 'when user is not present' do
      it 'does not update any user' do
        expect do
          patch :validate_email, params: { slug: 'invalid-slug' }
        end.not_to change(Person, :count)
      end
    end
  end
end
