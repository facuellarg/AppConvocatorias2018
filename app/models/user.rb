class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :user_documents
  has_many :documents, through: :user_documents
  
  alias_method :authenticate, :valid_password?

  def self.from_taken_payload(payload)
      self.find payload["sub"]
   end
end

