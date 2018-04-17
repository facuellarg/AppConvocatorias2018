class Convocation < ApplicationRecord
  belongs_to :admin

  has_many :convocation_dependences
  has_many :dependence, :through => :convocation_dependences
end
