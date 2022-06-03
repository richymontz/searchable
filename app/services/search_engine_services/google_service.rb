module SearchEngineServices
    class GoogleService
        def initialize(page, term, per_page = 10)
          @page, @term, @per_page = page.to_i, term, per_page
        end

        def call
            results(@page, @term, @per_page).map{|result| { url: result["link"], snipet: result["snippet"] }}
        end

        private

        def results(page, term, per_page)
             response = HTTParty.get(
                'https://www.googleapis.com/customsearch/v1',
                query: {
                    key: ENV['GOOGLE_PROJECT_API_KEY'],
                    cx: ENV['GOOGLE_ENGINE_ID'],
                    q: term,
                    num: per_page,
                    start: offset(page, per_page)
                }
            ).parsed_response["items"]
        end

        def offset(page, per_page)
            return 0 if page <= 1

            ((page - 1) * per_page) + 1
        end
    end
end