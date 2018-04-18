class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #validates :name,:lastname,:email,:permits,:password,:password_confirmation,:dependence,:phone_ext, presence: true
  #validates :password, confirmation: true

  belongs_to :dependence

  def populate
    out_object = {}
    out_object[:name] = self.name
    out_object[:lastname] = self.lastname
    out_object[:phone] = self.phone

    return out_object 
  end
end
