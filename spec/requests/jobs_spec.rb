# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Jobs', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:jobs) { create_list(:job, 10, recruiter: recruiter) }
  let(:recruiter_id) { recruiter.id }
  let(:job) { jobs.first }

  def authenticate
    post api_v1_auth_login_path, params: { recruiter: { email: recruiter.email, password: 'password' } }
    JSON.parse(response.body)['token']
  end

  let(:token) { authenticate }

  describe 'GET /api/v1/recruiters/:recruiter_id/jobs' do
    it 'returns a list of jobs' do
      get api_v1_recruiter_jobs_path(recruiter_id: recruiter.id), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(10)
    end

    it 'paginates the jobs' do
      get api_v1_recruiter_jobs_path(recruiter_id: recruiter.id, page: 1, per_page: 5), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(5)
    end
  end

  describe 'GET /api/v1/recruiters/:recruiter_id/jobs/:id' do
    it 'returns a job' do
      get api_v1_recruiter_job_path(recruiter_id: recruiter.id, id: job.id), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(job.id)
      expect(json['title']).to eq(job.title)
    end
  end

  describe 'POST /api/v1/recruiters/:recruiter_id/jobs' do
    let(:valid_attributes) do
      {
        job: {
          title: 'New Job',
          description: 'Job description',
          recruiter_id: recruiter.id
        }
      }
    end

    it 'creates a job' do
      post api_v1_recruiter_jobs_path(recruiter_id: recruiter.id), params: valid_attributes, headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:created)
      expect(json['title']).to eq('New Job')
      expect(json['description']).to eq('Job description')
    end
  end

  describe 'PATCH /api/v1/recruiters/:recruiter_id/jobs/:id' do
    let(:new_attributes) do
      {
        job: {
          title: 'Updated Job Title'
        }
      }
    end

    it 'updates the job' do
      patch api_v1_recruiter_job_path(recruiter_id: recruiter.id, id: job.id), params: new_attributes, headers: { 'Authorization' => "Bearer #{token}" }
      job.reload
      expect(job.title).to eq('Updated Job Title')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /api/v1/recruiters/:recruiter_id/jobs/:id' do
    it 'deletes the job' do
      delete api_v1_recruiter_job_path(recruiter_id: recruiter.id, id: job.id), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:no_content)
      expect { job.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
