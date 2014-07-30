require "spec_helper"

describe LocationsController do
  describe "routing" do

    it "routes to #index" do
      get("/boards/123/locations").should route_to("locations#index", :board_id => "123")
    end

    it "routes to #new" do
      get("/boards/123/locations/new").should route_to("locations#new", :board_id => "123")
    end

    it "routes to #show" do
      get("/boards/123/locations/1").should route_to("locations#show", :id => "1", :board_id => "123")
    end

    it "routes to #edit" do
      get("/boards/123/locations/1/edit").should route_to("locations#edit", :id => "1", :board_id => "123")
    end

    it "routes to #create" do
      post("/boards/123/locations").should route_to("locations#create", :board_id => "123")
    end

    it "routes to #update" do
      put("/boards/123/locations/1").should route_to("locations#update", :id => "1", :board_id => "123")
    end

    it "routes to #destroy" do
      delete("/boards/123/locations/1").should route_to("locations#destroy", :id => "1", :board_id => "123")
    end

  end
end
