require 'rails_helper'

RSpec.describe "Products Page", type: :system do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons:[taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_product_path(product.id)
  end

  it "Correct links are displayed in page header" do
    expect(page).to have_css('.breadcrumb.pull-right li', text: 'HOME')
    expect(page).to_not have_css('.breadcrumb.pull-right li', text: 'SHOP')
  end

  it "Redirects to category page when the link is clicked" do
    click_on "一覧ページへ戻る"
    expect(current_path).to eq(potepan_category_path(taxon.id))
  end
end
