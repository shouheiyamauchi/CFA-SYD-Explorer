require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      user = build(:user)
      controller.sign_in user
# require 'pry'; binding.pry
      get :home
      expect(response).to have_http_status(:success)
    end
  end

end
