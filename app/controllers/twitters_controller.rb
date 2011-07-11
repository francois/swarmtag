class TwittersController < ApplicationController

  def show
    lat, lng = params[:ll].split(",").map(&:to_f)

    search = Twitter::Search.new
    search = search.geocode(lat.to_f, lng.to_f, params.fetch(:radius, "50mi")).per_page(100).retweets

    populars = Hash.new {|h, k| h[k] = []}
    search.each do |result|
      result.text.scan( /#\w+\b/i ).each do |hashtag|
        populars[hashtag] << result
      end
    end

    tags = populars.reject {|key, array| array.length < 2}
    render :json => tags
  end

end
