class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def load_club
    @club = Club.find_by_subdomain!(request.subdomain)
  end
end
