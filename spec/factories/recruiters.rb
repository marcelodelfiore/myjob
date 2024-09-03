# frozen_string_literal: true

FactoryBot.define do
  factory :recruiter do
    name { "John Doe" }
    email { "john.doe@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
