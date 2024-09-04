# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Search', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job_dev) { create(:job, title: 'Software Engineer', description: 'Develop software', skills: 'Ruby, Rails', recruiter: recruiter) }
  let!(:job_data) { create(:job, title: 'Data Scientist', description: 'Analyze data', skills: 'Python, Machine Learning', recruiter: recruiter) }
  let!(:job_manager) { create(:job, title: 'Product Manager', description: 'Manage products', skills: 'Leadership, Agile', recruiter: recruiter) }

  describe 'GET /api/v1/publica/search' do
    it 'returns jobs filtered by title' do
      get '/api/v1/publica/search', params: { title: 'Software', page: 1, per_page: 5 }

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(1)
      expect(json.first['title']).to eq('Software Engineer')
    end

    it 'returns jobs filtered by description' do
      get '/api/v1/publica/search', params: { description: 'Analyze', page: 1, per_page: 5 }

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(1)
      expect(json.first['description']).to eq('Analyze data')
    end

    it 'returns jobs filtered by skills' do
      get '/api/v1/publica/search', params: { skills: 'Ruby', page: 1, per_page: 5 }

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(1)
      expect(json.first['skills']).to include('Ruby')
    end

    it 'paginates results correctly' do
      get '/api/v1/publica/search', params: { page: 1, per_page: 2 }

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(2)
    end
  end

  def json
    JSON.parse(response.body)
  end
end
# rubocop:enable RSpec/MultipleExpectations
