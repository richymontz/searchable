require 'rails_helper'
RSpec.describe SearchController, type: :request do
  describe 'GET results' do
    before do
      allow_any_instance_of(SearchEngineServices::SearchService).to receive(:call).and_return([{
        url: 'www.lax.com',
        snippet: 'mock something'
      },
      {
        url: 'www.url.com',
        snippet: 'mock something 2'
      }])
    end

    context "when engine param is missing" do
      it 'should returns 422 error' do
        get results_path, params: { text: 'something to search...' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when text param is missing" do
      it 'should returns 422 error' do
        get results_path, params: { engine: 'google' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when request with engine google" do
      it 'should returns 200 OK' do
        get results_path, params: { engine: 'google', text: 'sonething with bing' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).count).to eq(2) 
      end
    end

    context "when request with engine bing" do
      it 'should returns 200 OK' do
        get results_path, params: { engine: 'bing', text: 'sonething with bing' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).count).to eq(2) 
      end
    end

    context "when request with engine both" do
      it 'should returns 200 OK' do
        get results_path, params: { engine: 'both', text: 'sonething with bing' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).count).to eq(2) 
      end
    end
  end
end