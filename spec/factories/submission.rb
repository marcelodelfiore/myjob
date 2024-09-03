# frozen_string_literal: true

FactoryBot.define do
  factory :submission do
    sequence(:name) { |n| "Submission #{n}" }
    sequence(:email) { |n| "submission#{n}@example.com" }
    mobile_phone { '123-456-7890' }
    resume { 'resume.pdf' }
    association :job
  end
end

