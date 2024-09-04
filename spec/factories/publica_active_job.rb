# frozen_string_literal: true

FactoryBot.define do
  factory :publica_active_job do
    title { 'Job Title' }
    description { 'Job Description' }
    start_date { Date.today }
    end_date { Date.today + 30.days }
    status { 'active' }
    skills { 'Skill1, Skill2' }
    association :recruiter
  end
end
