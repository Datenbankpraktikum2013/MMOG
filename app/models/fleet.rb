class Fleet < ActiveRecord::Base
	has_many :shipfleets
	has_many :ships, :through => :shipfleets
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :user
	belongs_to :mission

  def self.getFleet(p)
    if p.is_a?Planet then
      Fleet.where(start_planet: p, target_planet: p)
    end
  end

  def self.getFleet(u)
    if u.is_a?User then
      Fleet.where(user_id: p)
    end
  end
end
