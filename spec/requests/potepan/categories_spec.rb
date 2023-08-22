require 'rails_helper'

RSpec.describe "Potepan::CategoriesController ", type: :request do
  describe "GET categories/show" do
      let(:taxonomy) { create(:taxonomy) }
      let(:taxon) { create(:taxon, parent_id: taxonomy.root) }
      let!(:product) { create(:product, taxons: [taxon]) }
      let(:image) { create(:image) }

      before do
        product.images << image
        get potepan_category_path(taxon.id)
      end

      it "HTTP Status Code must be 200" do
        expect(response).to have_http_status(:ok)
      end

      it "response body contains taxonomy and taxon name" do
        expect(response.body).to include(taxonomy.name)
        expect(response.body).to include(taxon.name)
      end

      it "response body contains product name" do
        expect(response.body).to include(product.name) 
      end

      it "response body contains product price" do
        expect(response.body).to include(product.display_price.to_s)
      end
  end
end
