json.array!(@posts) do |post|
  json.extract! post, :id, :image_url, :video_url, :description, :profile_id
  json.url post_url(post, format: :json)
end
