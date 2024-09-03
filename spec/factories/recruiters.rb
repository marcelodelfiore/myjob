# frozen_string_literal: true

FactoryBot.define do
  factory :recruiter do
    sequence(:name) { |n| "Recruiter #{n}" }
    sequence(:email) { |n| "recruiter#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
