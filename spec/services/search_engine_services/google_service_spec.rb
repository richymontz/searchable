require 'rails_helper'

RSpec.describe SearchEngineServices::GoogleService do
  before do
    allow_any_instance_of(SearchEngineServices::GoogleService).to receive(:call).and_return([{
      url: 'www.lax.com',
      snippet: 'mock something'
    },
    {
      url: 'www.url.com',
      snippet: 'mock something 2'
    }])
  end
  
  describe '#call' do
    it "returns results from google" do
      expect(described_class.new(1, 'termns').call.count).to eq(2)
    end
  end
end