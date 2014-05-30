json.array!(@project_members) do |project_member|
  json.extract! project_member, :id
  json.url project_member_url(project_member, format: :json)
end
