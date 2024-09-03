# frozen_string_literal: true

require 'faker'

recruiter = Recruiter.create!(
  name: 'John Doe',
  email: 'john.doe@example.com',
  password: 'password',
  password_confirmation: 'password'
)

5.times do
  Job.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.sentence(word_count: 20),
    start_date: Faker::Date.backward(days: 30),
    end_date: Faker::Date.forward(days: 60),
    status: %w[open closed pending].sample,
    skills: Faker::Job.key_skill,
    recruiter: recruiter
  )
end

Job.all.each do |job|
  2.times do
    Submission.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      mobile_phone: Faker::PhoneNumber.cell_phone_in_e164,
      resume: Faker::Lorem.paragraph(sentence_count: 10),
      job: job
    )
  end
end
