require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /potepan/products" do
    it "works! (now write some real specs)" do
      get potepan_products_index_path
      expect(response).to have_http_status(200)
    end
  end
end
