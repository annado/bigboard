json.array!(@projects) do |project|
  json.extract! project, :id, :name, :kickoff, :rolloff, :status, :location, :project_type, :initiative_id
  json.url project_url(project, format: :json)
end
