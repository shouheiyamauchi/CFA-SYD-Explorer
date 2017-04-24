json.extract! event, :id, :event_name, :event_description, :event_location, :event_cost, :event_date, :created_at, :updated_at
json.url event_url(event, format: :json)
