class JsonFetchController < ApplicationController
  before_filter :authenticate_user!

  def fetch
    object = Hash.new
    if !params["messages"].nil? then
      object.merge!({"msgs" => current_user.unread_messages,"reports" => Report.unread_reports(current_user)})
    end
    if !params["money"].nil? then
      object.merge!({"money" => current_user.money})
    end
    # weitere objekte anfuegen?, params erweitern...
    if !params["ressources"].nil? && !params["planet"].nil? then

      p = Planet.find(params["planet"].to_i)
      population = p.population
      energy = p.energy
      ore = p.ore
      crystal = p.crystal

      if population > 2000 then
        population = (population.to_i/1000).to_s + " k"
      end
      if energy > 2000 then
        energy = (energy.to_i/1000).to_s + " k"
      end
      if ore > 2000 then
        ore = (ore.to_i/1000).to_s + " k"
      end
      if crystal > 2000 then
        crystal = (crystal.to_i/1000).to_s + " k"
      end

      object.merge!({"population" => population, "ore" => ore, "crystal" => crystal, "energy" => energy}) if !p.nil?
    end


    respond_to do |format|
      format.json { render json: object}
    end
  end

end
