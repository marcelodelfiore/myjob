# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'validations' do
    subject { build(:job) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:recruiter_id) }
  end
end
