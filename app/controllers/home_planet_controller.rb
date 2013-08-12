class HomePlanetController < ApplicationController

  before_filter :authenticate_user!

  def index
    redirect_to(planet_path(current_user.home_planet));
  end

end
