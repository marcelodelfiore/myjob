json.extract! @submission, :id, :name, :email, :mobile_phone, :resume, :job_id, :created_at, :updated_at
json.job do
  json.extract! @submission.job, :id, :title, :description, :start_date, :end_date, :status, :skills
end
