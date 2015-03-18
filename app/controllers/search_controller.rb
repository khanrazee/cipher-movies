class SearchController < ApplicationController
  before_action :authenticate_user!
  PAGE_SIZE = 50

  def new
    @results =  ITunesSearchAPI.search(term: params[:term], country: params[:country] || "USA", media: "movie", entity:params[:entity] || "movie", limit: PAGE_SIZE )
    @results.collect{|r|r.deep_symbolize_keys!}

  end

  def index

  end

end