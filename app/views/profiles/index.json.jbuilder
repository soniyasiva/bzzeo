json.array!(@profiles) do |profile|
  json.extract! profile, :id, :name, :video, :representitive, :phone, :status, :category_id, :user_id
  json.url profile_url(profile, format: :json)
end
