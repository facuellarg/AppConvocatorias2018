class Document < ApplicationRecord
    mount_base64_uploader :file, DocumentUploader
end
