class ApplicationController < ActionController::Base
  protect_from_forgery

  # Disable layout for xhr requests
  layout proc{ |c| c.request.xhr? ? false : "application" }
end
