require 'rails_helper'

RSpec.describe "Products Page", type: :system do
  let(:taxon) { create(:taxon) }
  let(:taxon2) { create(:taxon) }
  let(:product) { create(:product, taxons:[taxon, taxon2]) }
  let(:related_products) do
    create_list(:product, 5, taxons: [taxon]) do |related_product|
      related_product.price = rand(10..20) 
      related_product.save
    end
  end
  let(:unrelated_product) { create(:product) }
  let(:image) { create(:image) }

  before do
    related_products.each do |related_product|
      related_product.images << create(:image)
    end
    product.images << image
    visit potepan_product_path(product.id)
  end

  it "Correct links are displayed in page header" do
    expect(page).to have_css('.breadcrumb.pull-right li', text: 'HOME')
    expect(page).to_not have_css('.breadcrumb.pull-right li', text: 'SHOP')
  end

  it "Redirect to category page when the link is clicked" do
    click_on "一覧ページへ戻る"
    expect(current_path).to eq(potepan_category_path(taxon.id))
  end

  it "Four related products are displayed" do
    expect(page.all(".productBox").count).to eq(4)
  end

  it "Fifth related product is not displayed" do
    expect(page).to_not have_content(related_products[4].name)
  end

  it "Unrelated product is not displayed" do
    expect(page).to_not have_content(unrelated_product.name)
  end

  it "Related products informations are displayed" do
    related_products[0..3].all? do |related_product|
      expect(page).to have_content(related_product.name)
      expect(page).to have_content(related_product.display_price.to_s)
    end
  end

  it "Redirect to the product page when the related products are clicked" do
    related_products[0..3].all? do |related_product|
      click_on (related_product.name)
      expect(current_path).to eq(potepan_product_path(related_product.id))
    end
  end
end
