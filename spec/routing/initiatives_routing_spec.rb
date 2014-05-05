require "spec_helper"

describe InitiativesController do
  describe "routing" do

    it "routes to #index" do
      get("/initiatives").should route_to("initiatives#index")
    end

    it "routes to #new" do
      get("/initiatives/new").should route_to("initiatives#new")
    end

    it "routes to #show" do
      get("/initiatives/1").should route_to("initiatives#show", :id => "1")
    end

    it "routes to #edit" do
      get("/initiatives/1/edit").should route_to("initiatives#edit", :id => "1")
    end

    it "routes to #create" do
      post("/initiatives").should route_to("initiatives#create")
    end

    it "routes to #update" do
      put("/initiatives/1").should route_to("initiatives#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/initiatives/1").should route_to("initiatives#destroy", :id => "1")
    end

  end
end
