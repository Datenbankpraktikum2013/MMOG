class UserTechnology < ActiveRecord::Base
  belongs_to :user
  belongs_to :technology

  def self.getTechnology(user)

    UserTechnology.where(:user_id => user).find_each do |i|

      name = Technology.where(:id => i.technology_id).first.name
      puts 'Technology_id: ' + i.technology_id.to_s
      puts 'Technology_rank: ' + i.rank.to_s
      puts 'Name: '   + name.to_s
    end

  end
end

