json.array!(@shares) do |share|
  json.extract! share, :id, :post_id, :profile_id
  json.url share_url(share, format: :json)
end
