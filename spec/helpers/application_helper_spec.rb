require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    let(:product) { double("Product", name: "Single Product") }

    it "returns base title when page_title is blank" do
      expect(full_title("")).to eq "BIGBAG Store"
    end

    it "returns the correct full title when page_title is provided" do
      page_title = product.name
      expect(full_title(page_title)).to eq "#{page_title} - BIGBAG Store"
    end

    it "returns error message when product name is nil" do
      page_title = nil
      expect{ full_title(page_title) }.to raise_error(RuntimeError, "Page title is nil")
    end
  end
end
