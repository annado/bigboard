require "spec_helper"

describe TeamsController do
  describe "routing" do

    it "routes to #index" do
      get("/boards/1/teams").should route_to("teams#index", :board_id => "1")
    end

    it "routes to #new" do
      get("/boards/1/teams/new").should route_to("teams#new", :board_id => "1")
    end

    it "routes to #show" do
      get("/boards/1/teams/1").should route_to("teams#show", :id => "1", :board_id => "1")
    end

    it "routes to #edit" do
      get("/boards/1/teams/1/edit").should route_to("teams#edit", :id => "1", :board_id => "1")
    end

    it "routes to #create" do
      post("/boards/1/teams").should route_to("teams#create", :board_id => "1")
    end

    it "routes to #update" do
      put("/boards/1/teams/1").should route_to("teams#update", :id => "1", :board_id => "1")
    end

    it "routes to #destroy" do
      delete("/boards/1/teams/1").should route_to("teams#destroy", :id => "1", :board_id => "1")
    end

  end
end
