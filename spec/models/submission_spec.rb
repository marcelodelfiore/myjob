# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:job) }
  end

  describe 'validations' do
    let(:recruiter) { create(:recruiter) }
    let(:job) { create(:job, recruiter: recruiter) }
    let(:submission) { build(:submission, job: job) }

    it 'is valid with valid attributes' do
      expect(submission).to be_valid
    end

    it 'validates uniqueness of email' do
      create(:submission, job: job, email: 'unique@example.com')

      duplicate_submission = build(:submission, job: job, email: 'unique@example.com')
      expect(duplicate_submission).not_to be_valid
      expect(duplicate_submission.errors[:email]).to include('has already been taken')
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
