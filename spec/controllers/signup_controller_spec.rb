require 'rails_helper'

RSpec.describe SignupController, type: :controller do

  describe "GET #parent" do
    it "returns http success" do
      get :parent
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #organiser" do
    it "returns http success" do
      get :organiser
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #child" do
    it "returns http success" do
      get :child
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #admin" do
    it "returns http success" do
      get :admin
      expect(response).to have_http_status(:success)
    end
  end

end
