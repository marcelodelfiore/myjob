# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  describe 'validations' do
    subject do
      build(:recruiter)
    end

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
  end
end
