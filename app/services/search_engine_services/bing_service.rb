module SearchEngineServices
    class BingService
        def search(page, term, per_page=10)
            response = HTTParty.get(
                'https://api.bing.microsoft.com/v7.0/search', 
                headers: { 'Ocp-Apim-Subscription-Key' => ENV['BING_API_KEY'] },
                query: {
                    q: term,
                    count: per_page + 1,
                    offset: offset(page, per_page + 1)
                }
            ).parsed_response
        end

        private

        def offset(page, per_page)
            return 0 if page <= 1

            (page - 1) * per_page
        end
    end
end

