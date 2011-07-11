class FoursquareController < ApplicationController

  def trending
    begin
      @venues = Skittles.trending(params[:ll], :limit => 10)
    rescue Skittles::Error => e
      Rails.logger.error e
      @venues = []
    end

    respond_to do |format|
      format.html
      format.json { render :json => @venues.to_json }
    end
  end

end
