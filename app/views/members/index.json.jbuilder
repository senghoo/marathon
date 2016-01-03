json.array!(@members) do |member|
  json.extract! member, :id, :name, :home, :github_id
  json.url member_url(member, format: :json)
end
