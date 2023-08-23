require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    it "returns http success with login" do
      user = create(:user)
      sign_in user

      get "/"
      expect(response.status).to eq(200)
    end

    it "does redirect on login page" do
      get "/"
      expect(response.status).to eq(302)
    end
  end

end
