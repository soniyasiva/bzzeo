json.array!(@partners) do |partner|
  json.extract! partner, :id, :profile_id, :partner_id
  json.url partner_url(partner, format: :json)
end
