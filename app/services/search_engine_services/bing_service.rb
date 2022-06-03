module SearchEngineServices
    class BingService
        def initialize(page, term, per_page = 10)
          @page, @term, @per_page = page.to_i, term, per_page
        end

        def call
            results(@page, @term, @per_page).map{|result| { url: result["id"], snipet: result["snippet"] }}
        end

        private

        def results(page, term, per_page)
            response = HTTParty.get(
                'https://api.bing.microsoft.com/v7.0/search', 
                headers: { 'Ocp-Apim-Subscription-Key' => ENV['BING_API_KEY'] },
                query: {
                    q: term,
                    count: per_page + 1,
                    offset: offset(page, per_page + 1)
                }
            ).parsed_response["webPages"]["value"]
        end

        def offset(page, per_page)
            return 0 if page <= 1

            (page - 1) * per_page
        end
    end
end

