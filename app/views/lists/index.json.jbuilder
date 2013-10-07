json.array!(@lists) do |list|
  json.extract! list, 
  json.url list_url(list, format: :json)
end
