require 'rails_helper'

RSpec.describe SignupController, type: :controller do

  describe "GET #parent" do
    it "can sign up as an organiser if not logged in" do
      get :parent
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #organiser" do
    it "can sign up as an organiser if not logged in" do
      get :organiser
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #organiser" do
    it "can't sign up as an organiser if logged in" do
      user = build(:user)
      controller.sign_in user
      get :organiser
      expect(response).to_not have_http_status(:success)
    end
  end

  describe "GET #child" do
    it "can sign up if logged in as a parent" do
      user = build(:user, :role => "parent")
      controller.sign_in user
      get :child
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #child" do
    it "can't sign up as a child unless logged in as a parent" do
      user = build(:user, :role => "child")
      controller.sign_in user
      get :child
      expect(response).to_not have_http_status(:success)
    end
  end

  describe "GET #admin" do
    pending "returns http success" do
      get :admin
      expect(response).to have_http_status(:success)
    end
  end

end
