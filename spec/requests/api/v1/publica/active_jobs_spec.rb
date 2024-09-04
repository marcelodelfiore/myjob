# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Jobs', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:active_jobs) { create_list(:job, 15, status: 'active', recruiter: recruiter) }
  let!(:inactive_jobs) { create_list(:job, 5, status: 'inactive', recruiter: recruiter) }

  describe 'GET /api/v1/publica/active_jobs' do
    it 'returns a paginated list of active jobs' do
      get '/api/v1/publica/active_jobs', params: { page: 1, per_page: 5 }

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(5)
      expect(json).to all(include('status' => 'active'))
    end

    it 'returns the correct page of results' do
      get '/api/v1/publica/active_jobs', params: { page: 2, per_page: 5 }

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(5)
    end
  end

  def json
    JSON.parse(response.body)
  end
end
# rubocop:enable RSpec/MultipleExpectations
