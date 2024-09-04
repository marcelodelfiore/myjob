json.jobs do
  paginated_jobs.each do |job|
    json.extract! job, :id, :title, :description, :start_date, :end_date, :status, :skills, :recruiter_id, :created_at, :updated_at
    json.recruiter do
      json.extract! job.recruiter, :id, :name, :email
    end
  end
end

json.page paginated_jobs.current_page
json.pages paginated_jobs.total_pages
json.per_page paginated_jobs.limit_value
json.total paginated_jobs.total_count
