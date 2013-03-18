class Food < ActiveRecord::Base
  attr_accessible :energy, :englishName, :fat, :name, :proteins, :type, :water
end
