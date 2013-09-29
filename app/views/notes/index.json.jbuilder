json.array!(@notes) do |note|
  json.extract! note, :title, :body
  json.url note_url(note, format: :json)
end
