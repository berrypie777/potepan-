require 'rails_helper'

RSpec.describe "Potepan::ProductsController", type: :request do
  describe "/potepan/products/:product_id" do
    let(:product) { create(:product) }

    before do
      get potepan_product_path(product.id)
    end

    it "HTTP Status Code must be 200" do
      expect(response).to have_http_status(:ok)
    end

    it "show template is successfully rendered" do
      expect(response).to render_template :show
    end

    it "response body contains the product name" do
      expect(response.body).to include(product.name)
    end

    it "response body contains the product price" do
      expect(response.body).to include(product.display_price.to_s)
    end

    it "response body contains the product description" do
      expect(response.body).to include(product.description)
    end
  end
end
