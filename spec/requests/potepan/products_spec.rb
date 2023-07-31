require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "Potepan::ProductsController", type: :request do
  describe "potepan/products/show" do
    let!(:product) { create(:product) }

    before do
      get "/potepan/products/#{product.id}"
    end

    it "HTTP Status Code must be 200" do
      expect(response).to have_http_status(:ok)
    end

    it "show template is successfully rendered" do
      expect(response).to render_template :show
    end

    it "@product is successfully assigned" do
      expect(assigns(:product)).to eq product
    end

  end
end
