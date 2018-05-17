class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #validates :name,:lastname,:email,:permits,:password,:password_confirmation,:dependence,:phone_ext, presence: true
  #validates :password, confirmation: true

  belongs_to :dependence
  has_many :convocations
  alias_method :authenticate, :valid_password?

  def self.from_taken_payload(payload)
      self.find payload["sub"]
  end

  def populate
    out_object = {}
    out_object[:name] = self.name
    out_object[:lastname] = self.lastname
    out_object[:phone_ext] = self.phone_ext

    return out_object 
  end
end
