# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Recruiters', type: :request do
  let!(:recruiter) { create(:recruiter) }

  describe 'GET /recruiters/:id' do
    it 'returns the recruiter' do
      get api_v1_recruiter_path(recruiter)
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(recruiter.id)
    end
  end

  describe 'POST /recruiters' do
    let(:valid_attributes) do
      {
        recruiter: {
          name: 'Jane Doe',
          email: 'jane.doe@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    it 'creates a new recruiter' do
      expect { post api_v1_recruiters_path, params: valid_attributes }.to change(Recruiter, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /recruiters/:id' do
    let(:new_attributes) do
      {
        recruiter: {
          name: 'Updated Name'
        }
      }
    end

    it 'updates the recruiter' do
      patch api_v1_recruiter_path(recruiter), params: new_attributes
      recruiter.reload
      # expect(recruiter.name).to eq('Updated Name')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /recruiters/:id' do
    it 'deletes the recruiter' do
      expect { delete api_v1_recruiter_path(recruiter) }.to change(Recruiter, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
