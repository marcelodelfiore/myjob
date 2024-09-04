# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'JobDetail', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }

  describe 'GET /api/v1/publica/job_detail/:id' do
    context 'when the job exists' do
      it 'returns the job details' do
        get "/api/v1/publica/job_detail/#{job.id}"

        expect(response).to have_http_status(:success)
        expect(json['id']).to eq(job.id)
        expect(json['title']).to eq(job.title)
        expect(json['description']).to eq(job.description)
        expect(json['status']).to eq(job.status)
      end
    end

    context 'when the job does not exist' do
      it 'returns a 404 not found status' do
        expect { get '/api/v1/publica/job_detail/99999' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  def json
    JSON.parse(response.body)
  end
end
# rubocop:enable RSpec/MultipleExpectations
