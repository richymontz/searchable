class SearchController < ApplicationController
  def results
    search_items = SearchEngineServices::SearchService.new(
      search_params[:engine],
      search_params[:text],
      search_params[:page]
    ).call

    if search_items 
      render json: search_items, status: :ok
    else
      render json: { error: 'Something went wrong, please check param values' }, status: :bad_request
    end

  end
  
  private

  def search_params
    params.require(:engine)
    params.require(:text)
    params.permit(:engine, :text, :page)
  end
end
