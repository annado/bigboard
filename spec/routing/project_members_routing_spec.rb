require "spec_helper"

describe ProjectMembersController do
  describe "routing" do

    it "routes to #new" do
      get("/projects/1/project_members/new").should route_to("project_members#new", :project_id => "1")
    end

    it "routes to #show" do
      get("/projects/1/project_members/1").should route_to("project_members#show", :id => "1", :project_id => "1")
    end

    it "routes to #edit" do
      get("/projects/1/project_members/1/edit").should route_to("project_members#edit", :id => "1", :project_id => "1")
    end

    it "routes to #create" do
      post("/projects/1/project_members").should route_to("project_members#create", :project_id => "1")
    end

    it "routes to #update" do
      put("/projects/1/project_members/1").should route_to("project_members#update", :id => "1", :project_id => "1")
    end

    it "routes to #destroy" do
      delete("/projects/1/project_members/1").should route_to("project_members#destroy", :id => "1", :project_id => "1")
    end

  end
end
