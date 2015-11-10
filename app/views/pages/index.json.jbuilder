json.array!(@pages) do |page|
  json.extract! page, :id, :html, :slug
  json.url page_url(page, format: :json)
end
