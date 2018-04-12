json.extract! submit, :id, :title, :url, :text, :created_at, :updated_at
json.url submit_url(submit, format: :json)
