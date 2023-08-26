require 'rails_helper'

RSpec.describe "Potepan::ProductsController", type: :request do
  describe "/potepan/products/:product_id" do
    let(:product) { create(:product) }
    let(:taxon) { create(:taxon) }
    let(:related_products) { create(:product) }

    before do
      product.taxons << taxon
      get potepan_product_path(product.id)
    end

    it "HTTP Status Code must be 200" do
      expect(response).to have_http_status(:ok)
    end

    it "response body contains the product informations" do
      expect(response.body).to include(product.name)
      expect(response.body).to include(product.display_price.to_s)
      expect(response.body).to include(product.description)
    end

    it "response body contains the related products informations" do
      related_products = product.related_products
      related_products.each do |related_product|
        expect(response.body).to include(related_product.name)
        expect(response.body).to include(related_product.display_price.to_s)
      end
    end
  end
end
