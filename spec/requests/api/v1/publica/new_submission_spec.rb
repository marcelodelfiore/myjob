# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe 'NewSubmission', type: :request do
  let!(:recruiter) { create(:recruiter) }
  let!(:job) { create(:job, recruiter: recruiter) }
  let(:valid_attributes) do
    {
      submission: {
        name: 'John Doe',
        email: 'johndoe@example.com',
        mobile_phone: '1234567890',
        resume: 'path/to/resume.pdf',
        job_id: job.id
      }
    }
  end
  let(:invalid_attributes) do
    {
      submission: {
        name: '',
        email: 'invalid-email',
        mobile_phone: '',
        resume: '',
        job_id: nil
      }
    }
  end

  describe 'POST /api/v1/publica/new_submission' do
    context 'with valid parameters' do
      it 'creates a new submission' do
        expect { post '/api/v1/publica/new_submission', params: valid_attributes }.to change(Submission, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('John Doe')
        expect(json['email']).to eq('johndoe@example.com')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new submission and returns errors' do
        expect { post '/api/v1/publica/new_submission', params: invalid_attributes }.not_to change(Submission, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  def json
    JSON.parse(response.body)
  end
end
# rubocop:enable RSpec/MultipleExpectations
