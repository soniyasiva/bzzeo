json.array!(@notifications) do |notification|
  json.extract! notification, :id, :message, :link, :profile_id
  json.url notification_url(notification, format: :json)
end
