require 'rails_helper'

RSpec.describe "Welcomes", type: :request do

  describe "GET /top" do
    it "returns http success" do
      get "/welcome/top"
      expect(response).to have_http_status(:success)
    end
  end

end
