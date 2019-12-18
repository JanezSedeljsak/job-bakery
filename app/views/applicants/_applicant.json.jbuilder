json.extract! applicant, :id, :User_id, :Job_id, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
