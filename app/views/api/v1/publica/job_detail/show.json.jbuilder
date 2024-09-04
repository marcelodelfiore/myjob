json.extract! @job, :id, :title, :description, :start_date, :end_date, :status, :skills, :recruiter_id, :created_at, :updated_at
json.recruiter do
  json.extract! @job.recruiter, :id, :name, :email
end
