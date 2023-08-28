require 'rails_helper'

RSpec.describe "Potepan::ProductsController", type: :request do
  describe "/potepan/products/:product_id" do
    let(:product) { create(:product) }
    let(:taxon) { create(:taxon) }
    let(:related_products) do
      create_list(:product, 5, taxons: [taxon]).each_with_index do |related_product, index|
        related_product.price = 10.0 * index
        related_product.save
      end
    end

    before do
      product.taxons << taxon
      get potepan_product_path(product.id)
    end

    it "HTTP Status Code must be 200" do
      expect(response).to have_http_status(:ok)
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

    it "response body contains the related products" do
      product.related_products.all? do |related_product|
        expect(response.body).to include(related_product.name)
        expect(response.body).to include(related_product.display_price.to_s)
      end
    end

    it "response body contains the four related products" do
      product.related_products.first(4).all? do |related_product|
        expect(response.body).to include(related_product.name)
        expect(response.body).to include(related_product.display_price.to_s)
      end
    end

    it "response body do not contain the fifth related product" do
      product.related_products.all? do |related_product|
        expect(response.body).not_to include(related_products[4].name)
        expect(response.body).not_to include(related_products[4].display_price.to_s)  
      end
    end
  end
end
