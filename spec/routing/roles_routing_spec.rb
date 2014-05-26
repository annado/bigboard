require "spec_helper"

describe RolesController do
  describe "routing" do

    it "routes to #index" do
      get("/boards/1/roles").should route_to("roles#index", :board_id => "1")
    end

    it "routes to #new" do
      get("/boards/1/roles/new").should route_to("roles#new", :board_id => "1")
    end

    it "routes to #show" do
      get("/boards/1/roles/1").should route_to("roles#show", :id => "1", :board_id => "1")
    end

    it "routes to #edit" do
      get("/boards/1/roles/1/edit").should route_to("roles#edit", :id => "1", :board_id => "1")
    end

    it "routes to #create" do
      post("/boards/1/roles").should route_to("roles#create", :board_id => "1")
    end

    it "routes to #update" do
      put("/boards/1/roles/1").should route_to("roles#update", :id => "1", :board_id => "1")
    end

    it "routes to #destroy" do
      delete("/boards/1/roles/1").should route_to("roles#destroy", :id => "1", :board_id => "1")
    end

  end
end
