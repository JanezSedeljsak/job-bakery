json.extract! question, :id, :job_id, :body, :created_at, :updated_at
json.url question_url(question, format: :json)
