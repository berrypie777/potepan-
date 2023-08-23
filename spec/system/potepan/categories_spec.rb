require 'rails_helper'

RSpec.describe "Category Page", type: :system do
  let(:taxonomy) { create(:taxonomy, name:'Categories') }
  let(:taxonomy2) { create(:taxonomy, name:'Brand') }
  let(:taxon) { create(:taxon, name:'Shirts', taxonomy:taxonomy, parent:taxonomy.root) }
  let(:taxon2) { create(:taxon, name:'Solidus', taxonomy:taxonomy2, parent:taxonomy2.root) }
  let(:taxon3) { create(:taxon, name:'Ruby', taxonomy:taxonomy2, parent:taxonomy2.root) }
  let!(:product) { create(:product, name:'SOLIDUS GIRLY', taxons:[taxon, taxon2]) }
  let!(:product2) { create(:product, name:'RUBY MUG', taxons:[taxon3]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  it "Correct links are displayed in page header" do
    expect(page).to have_css('.breadcrumb.pull-right li', text: 'HOME')
    expect(page).to have_css('.breadcrumb.pull-right li', text: 'SHOP')
  end

  it "Category informartions are displayed in the sidebar" do
    within ".side-nav" do
      expect(page).to have_content(taxonomy.name)
      expect(page).to have_content(taxonomy2.name)
      expect(page).to have_content(taxon.name)
      expect(page).to have_content(taxon2.name)
      expect(page).to have_content(taxon.products.count)
      expect(page).to have_content(taxon2.products.count)
    end
  end

  it "Click on a category to go to the correct product listing page" do
    within ".side-nav" do
      click_on taxon.name
      expect(current_path).to eq(potepan_category_path(taxon.id))
    end
  end

  it "Correct products belonging to a category are displayed" do
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.display_price)
  end

  it "Products that do not belong to a category are not displayed" do
    click_on taxon.name
    expect(page).not_to have_content(product2.name)
  end

  it "Click on a product name to go to the correct product page"  do
    click_on product.name
    expect(current_path).to eq(potepan_product_path(product.id))
  end
end
