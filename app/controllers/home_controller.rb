# Home controller, handles views non-related to other models
class HomeController < ApplicationController
  # Skip security filter for common views
  skip_before_filter :authenticate_session, :only => [:index, :about]
  
  # At this moment no data passes through controller
  def index
  end

  def about
  end
end
