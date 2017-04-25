require 'rails_helper'

RSpec.describe ParentsController, type: :controller do

  describe "GET #events" do
    it "returns http success" do
      get :events
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #children" do
    it "returns http success" do
      get :children
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #point_store" do
    it "returns http success" do
      get :point_store
      expect(response).to have_http_status(:success)
    end
  end

end
