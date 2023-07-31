require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "returns base title when page_title is blank" do
      expect(full_title("")).to eq "BIGBAG Store"
    end

    it "returns the correct full title when page_title is provided" do
      page_title = "Single Product"
      expect(full_title(page_title)).to eq "#{page_title} - BIGBAG Store"
    end
  end
end
