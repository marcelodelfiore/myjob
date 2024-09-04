json.array!(@recruiters) do |recruiter|
  json.id recruiter.id
  json.name recruiter.name
  json.email recruiter.email
  json.created_at recruiter.created_at
  json.updated_at recruiter.updated_at
end
