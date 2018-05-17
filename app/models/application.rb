class Application < ApplicationRecord
  belongs_to :user
  belongs_to :convocation

  has_many :application_documents
  has_many :user_documents, through: :application_documents
end
