# frozen_string_literal: true

Recruiter.destroy_all
Job.destroy_all
Submission.destroy_all

recruiter = Recruiter.create!(
  name: 'Recruiter Name',
  email: 'recruiter@example.com',
  password: 'password123'
)

jobs = []
10.times do |i|
  jobs << Job.create!(
    title: "Job Title #{i + 1}",
    description: "Job Description #{i + 1}",
    start_date: Date.today,
    end_date: Date.today + 30.days,
    status: 'open',
    skills: 'Ruby, Rails',
    recruiter: recruiter
  )
end

jobs.each do |job|
  10.times do |i|
    Submission.create!(
      name: "Applicant #{i + 1}",
      email: "applicant#{job.id}_#{i + 1}@example.com",
      mobile_phone: "123-456-7890",
      resume: "resume_#{i + 1}.pdf",
      job: job
    )
  end
end

puts "Seed data created: #{Recruiter.count} recruiters, #{Job.count} jobs, #{Submission.count} submissions"
