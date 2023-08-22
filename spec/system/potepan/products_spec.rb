require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  let(:taxon) { create(:taxon) }
  let!(:product) { create(:product, taxons:[taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_product_path(product.id)
  end

  it "Redirects to category page when the link is clicked" do
    if product.taxons.first.present?
      click_on "一覧ページへ戻る"
      expect(current_path).to eq(potepan_category_path(taxon.id))
    else
      click_on "一覧ページへ戻る"
      expect(current_path).to eq(potepan_index_url)
    end  
  end
end
