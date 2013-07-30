class Sunsystem < ActiveRecord::Base

  belongs_to :galaxy
  has_many :planets

end
