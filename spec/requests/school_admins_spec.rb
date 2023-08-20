require 'rails_helper'

RSpec.describe "SchoolAdmins", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/school_admins/index"
      expect(response).to have_http_status(:success)
    end
  end

end
