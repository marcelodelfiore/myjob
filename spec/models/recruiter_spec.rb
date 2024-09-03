# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  describe 'validations' do
    subject do
      build(:recruiter, password: nil)
    end

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_presence_of(:name) }

    it 'requires a password' do
      recruiter = Recruiter.new(password: nil)
      recruiter.validate
      expect(recruiter.errors[:password]).to include("can't be blank")
    end

    it 'requires a password of minimum 6 characters' do
      recruiter = Recruiter.new(password: 'short')
      recruiter.validate
      expect(recruiter.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end
end
