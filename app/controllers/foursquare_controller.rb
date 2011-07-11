class FoursquareController < ApplicationController

  def trending
    begin
      @venues = Skittles.trending(params[:ll], :limit => 10)
    rescue Skittles::Error => e
      @venues = []
    end

    render :json => @venues
  end

end