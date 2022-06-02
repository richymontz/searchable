module SearchEngineServices
    class GoogleService
        def search(page, term, per_page=10)
            response = HTTParty.get(
                'https://www.googleapis.com/customsearch/v1',
                query: {
                    key: ENV['GOOGLE_PROJECT_API_KEY'],
                    cx: ENV['GOOGLE_ENGINE_ID'],
                    q: term,
                    num: per_page,
                    start: offset(page, per_page)
                }
            ).parsed_response
        end

        private

        def offset(page, per_page)
            return 0 if page <= 1

            ((page - 1) * per_page) + 1
        end
    end
end