# frozen_string_literal: true

FactoryBot.define do
  factory :submission do
    email { "example@example.com" }
    association :job
  end
end
