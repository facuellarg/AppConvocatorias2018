class UserDocument < ApplicationRecord
  belongs_to :student
  belongs_to :document
end
