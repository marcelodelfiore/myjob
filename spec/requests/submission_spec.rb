# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Submissions', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }
  let!(:submissions) { create_list(:submission, 10, job: job) }
  let(:submission) { submissions.first }

  def authenticate
    post api_v1_auth_login_path, params: { recruiter: { email: recruiter.email, password: 'password' } }
    JSON.parse(response.body)['token']
  end

  let(:token) { authenticate }

  describe 'GET /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions' do
    it 'returns a list of submissions' do
      get api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(10)
    end

    it 'paginates the submissions' do
      get api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id, page: 1, per_page: 5), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(5)
    end
  end

  describe 'GET /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    it 'returns a submission' do
      get api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(submission.id)
      expect(json['name']).to eq(submission.name)
      expect(json['email']).to eq(submission.email)
      expect(json['mobile_phone']).to eq(submission.mobile_phone)
      expect(json['resume']).to eq(submission.resume)
    end
  end

  describe 'POST /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions' do
    let(:valid_attributes) do
      {
        submission: {
          name: 'New Submission',
          email: 'new@example.com',
          mobile_phone: '123-456-7890',
          resume: 'link_to_resume',
          job_id: job.id
        }
      }
    end

    it 'creates a submission' do
      post api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id), params: valid_attributes, headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:created)
      expect(json['name']).to eq('New Submission')
      expect(json['email']).to eq('new@example.com')
      expect(json['mobile_phone']).to eq('123-456-7890')
      expect(json['resume']).to eq('link_to_resume')
    end
  end

  describe 'PATCH /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    let(:new_attributes) do
      {
        submission: {
          name: 'Updated Submission Name'
        }
      }
    end

    it 'updates the submission' do
      patch api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id), params: new_attributes, headers: { 'Authorization' => "Bearer #{token}" }
      submission.reload
      expect(submission.name).to eq('Updated Submission Name')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    it 'deletes the submission' do
      delete api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id), headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:no_content)
      expect { submission.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

# rubocop:enable RSpec/MultipleExpectations
