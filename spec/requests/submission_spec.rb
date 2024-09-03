# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'Submissions', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }
  let!(:submissions) { create_list(:submission, 10, job: job) }
  let(:submission) { submissions.first }

  describe 'GET /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions' do
    it 'returns a list of submissions' do
      get api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id)
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(10)
    end

    it 'paginates the submissions' do
      get api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id, page: 1, per_page: 5)
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(5)
    end
  end

  describe 'GET /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    it 'returns the submission' do
      get api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id)
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(submission.id)
      expect(json['email']).to eq(submission.email)
    end
  end

  describe 'POST /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions' do
    let(:valid_attributes) do
      {
        submission: {
          name: 'New Submission',
          email: 'new.submission@example.com',
          mobile_phone: '987-654-3210',
          resume: 'new_resume.pdf',
          job_id: job.id
        }
      }
    end

    it 'creates a new submission' do
      expect { post api_v1_recruiter_job_submissions_path(recruiter_id: recruiter.id, job_id: job.id), params: valid_attributes }.to change(Submission, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(json['name']).to eq('New Submission')
      expect(json['email']).to eq('new.submission@example.com')
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
      patch api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id), params: new_attributes
      submission.reload
      expect(submission.name).to eq('Updated Submission Name')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /api/v1/recruiters/:recruiter_id/jobs/:job_id/submissions/:id' do
    it 'deletes the submission' do
      expect { delete api_v1_recruiter_job_submission_path(recruiter_id: recruiter.id, job_id: job.id, id: submission.id) }.to change(Submission, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
