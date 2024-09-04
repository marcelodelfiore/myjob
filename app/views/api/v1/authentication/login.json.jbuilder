json.token token
json.recruiter do
  json.extract! @recruiter, :id, :name, :email
end
