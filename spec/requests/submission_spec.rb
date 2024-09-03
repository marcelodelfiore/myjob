# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Submissions', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }
  let!(:submission) { create(:submission, job: job) }

  describe 'GET /recruiters/:recruiter_id/jobs/:job_id/submissions' do
    it 'returns a list of submissions' do
      get api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id)
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(1)
    end
  end

  describe 'GET /recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    it 'returns a submission' do
      get api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id)
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(submission.id)
      expect(json['email']).to eq(submission.email)
    end
  end

  describe 'POST /recruiters/:recruiter_id/jobs/:job_id/submissions' do
    let(:valid_attributes) do
      {
        submission: {
          name: 'Applicant Name',
          email: 'applicant@example.com',
          mobile_phone: '1234567890',
          resume: 'resume.pdf',
          job_id: job.id
        }
      }
    end

    it 'creates a submission' do
      post api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id), params: valid_attributes
      expect(response).to have_http_status(:created)
      expect(json['name']).to eq('Applicant Name')
      expect(json['email']).to eq('applicant@example.com')
    end
  end

  describe 'PATCH /recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    let(:new_attributes) do
      {
        submission: {
          name: 'Updated Applicant Name'
        }
      }
    end

    it 'updates the submission' do
      patch api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id), params: new_attributes
      submission.reload
      expect(submission.name).to eq('Updated Applicant Name')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    it 'deletes the submission' do
      delete api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id)
      expect(response).to have_http_status(:no_content)
      expect { submission.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
