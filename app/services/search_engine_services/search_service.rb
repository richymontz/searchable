module SearchEngineServices
  class SearchService

    PER_PAGE = 10

    def initialize(engine, text, page)
      @engine, @text, @page = engine, text, page
    end

    def call
      search_engines[@engine.to_sym]&.call(@page, @text)
    end

    private 

    def search_engines
      {
        bing: ->(page, term, per_page = PER_PAGE) {
          BingService.new(page, term, per_page).call
        },
        google: -> (page, term, per_page = PER_PAGE) { 
          GoogleService.new(page, term, per_page).call
        },
        both: -> (page, term, per_page = PER_PAGE) { 
          google = GoogleService.new(page, term, per_page).call
          bing =  BingService.new(page, term, per_page).call

          (google + bing).uniq { |item| item[:url] }
        } 
      }
    end
  end
end