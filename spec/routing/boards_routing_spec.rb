require "spec_helper"

describe BoardsController do
  describe "routing" do

    it "routes to #index" do
      get("/boards").should route_to("boards#index")
    end

    it "routes to #new" do
      get("/boards/new").should route_to("boards#new")
    end

    it "routes to #show" do
      get("/boards/1").should route_to("boards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/boards/1/edit").should route_to("boards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/boards").should route_to("boards#create")
    end

    it "routes to #update" do
      put("/boards/1").should route_to("boards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/boards/1").should route_to("boards#destroy", :id => "1")
    end

  end
end
