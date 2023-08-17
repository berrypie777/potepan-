require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    subject { full_title(page_title) }
  
    context 'when page_title is blank' do
      let(:page_title) { "" }  
      it 'returns the base title' do
        expect(subject).to eq("BIGBAG Store")
      end
    end

    context 'when page_title is nil' do
      let(:page_title) { nil }  
      it 'returns the base title' do
        expect(subject).to eq("BIGBAG Store")
      end
    end
  
    context 'when page_title is provided' do
      let(:page_title) { "Product" }
      it 'returns the full title' do
        expect(subject).to eq("Product - BIGBAG Store")
      end
    end
  end 
end
