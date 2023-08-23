require "rails_helper"

RSpec.describe BatchesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/courses/1/batches").to route_to("batches#index", course_id: "1")
    end

    it "routes to #new" do
      expect(get: "/courses/1/batches/new").to route_to("batches#new", course_id: "1")
    end

    it "routes to #show" do
      expect(get: "/courses/1/batches/1").to route_to("batches#show", course_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/courses/1/batches/1/edit").to route_to("batches#edit", course_id: "1", id: "1")
    end


    it "routes to #create" do
      expect(post: "/courses/1/batches").to route_to("batches#create", course_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/courses/1/batches/1").to route_to("batches#update", course_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/courses/1/batches/1").to route_to("batches#update", course_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/courses/1/batches/1").to route_to("batches#destroy", course_id: "1", id: "1")
    end
  end
end
