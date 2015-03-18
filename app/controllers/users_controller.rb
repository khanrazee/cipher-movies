class UsersController < ApplicationController
  PAGE_SIZE = 50
  before_action :authenticate_user!, :only => [:update,:edit,:show,:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      return redirect_to search_users_path
    end
    render :new
  end

  def edit
    #for later
  end

  def update
    #for later
  end

  # def show
  #
  # end

  def index

  end

  def search
    if params[:term].present?
      puts"#{params[:term]}"
      @results =  ITunesSearchAPI.search(term: params[:term], country: params[:country], media: "movie", entity:params[:entity] || "movie", limit: PAGE_SIZE )
      # @results =  ITunesSearchAPI.search(term: params[:term], country: params[:country] || "USA", media: "movie", entity:params[:entiry] || "movie", limit: PAGE_SIZE )
      @results.collect{|r|r.deep_symbolize_keys!} if @results.present?
      puts "result is :#{@results}***********************************"*10
    end
  end


  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end