class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications:
      {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    self.joins(boats: :classifications).group("boats.id").having('classifications.name': "Motorboat" && "Sailboat").sort
  end

  def self.non_sailors
     self.where.not("name IN (?)", self.sailors.pluck(:name))
    #self.joins(boats: :classifications).group("boats.id").where.not(classifications: {name: "Sailboat"})
  end

end
