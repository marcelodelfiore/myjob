# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Recruiters', type: :request do
  let!(:recruiter) { create(:recruiter) }
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

  def authenticate
    post api_v1_auth_login_path, params: { recruiter: { email: recruiter.email, password: 'password' } }
    JSON.parse(response.body)['token']
  end

  let(:token) { authenticate }

  describe 'GET /recruiters/:id' do
    it 'returns the recruiter' do
      get api_v1_recruiter_path(recruiter), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(recruiter.id)
    end
  end

  describe 'POST /recruiters' do
    it 'creates a new recruiter' do
      expect { post api_v1_recruiters_path, params: valid_attributes, headers: { 'Authorization' => "Bearer #{token}" } }.to change(Recruiter, :count).by(1)
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
      patch api_v1_recruiter_path(recruiter), params: new_attributes, headers: { 'Authorization' => "Bearer #{token}" }
      recruiter.reload
      expect(recruiter.name).to eq('Updated Name')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /recruiters/:id' do
    it 'deletes the recruiter' do
      expect { delete api_v1_recruiter_path(recruiter), headers: { 'Authorization' => "Bearer #{token}" } }.to change(Recruiter, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

  # Pagination tests
  describe 'GET /recruiters' do
    let!(:recruiters) { create_list(:recruiter, 10) }

    it 'paginates recruiters' do
      get api_v1_recruiters_path(page: 1, per_page: 5), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(5)
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
