json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :sender_id, :receiver_id, :message, :read
  json.url conversation_url(conversation, format: :json)
end
