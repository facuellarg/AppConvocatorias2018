class ApplicationDocument < ApplicationRecord
  belongs_to :application
  belongs_to :user_document
end
