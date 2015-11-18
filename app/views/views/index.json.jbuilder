json.array!(@views) do |view|
  json.extract! view, :id, :profile_id, :viewed_id
  json.url view_url(view, format: :json)
end
