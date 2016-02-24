json.array!(@likes) do |like|
  json.extract! like, :id, :profile_id, :post_id
  json.url like_url(like, format: :json)
end
