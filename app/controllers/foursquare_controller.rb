class FoursquareController < ApplicationController

  def trending
    @venues = Skittles.trending(params[:ll], :limit => 10)
    render :json => @venues
  end

end