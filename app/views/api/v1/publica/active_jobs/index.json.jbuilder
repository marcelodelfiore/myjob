json.jobs do
  @jobs.each do |job|
    json.extract! job, :id, :title, :description, :start_date, :end_date, :status, :skills, :recruiter_id, :created_at, :updated_at
    json.recruiter do
      json.extract! job.recruiter, :id, :name, :email
    end
  end
end

json.page @jobs.current_page
json.pages @jobs.total_pages
json.per_page @jobs.limit_value
json.total @jobs.total_count
