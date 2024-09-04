# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { "Software Engineer" }
    description { "Responsible for developing software applications." }
    recruiter_id { 1 }
    skills { 'Ruby' }
  end
end
