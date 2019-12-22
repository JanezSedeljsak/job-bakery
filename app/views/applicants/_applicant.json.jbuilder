json.extract! applicant, :id, :users_id, :jobs_id, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
