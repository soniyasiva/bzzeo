json.array!(@friends) do |friend|
  json.extract! friend, :id, :profile_id, :friend_id, :mutual
  json.url friend_url(friend, format: :json)
end
